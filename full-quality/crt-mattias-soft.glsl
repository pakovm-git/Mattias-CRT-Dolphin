// CRT Emulation
// by Mattias
// https://www.shadertoy.com/view/lsB3DV
// Fixed-style edition: crt-mattias-soft. See README.md.
// Style constants: BLURRADIUS=0.8, COLUMNS=0.6, GHOSTSTRENGTH=0.3, GLOWSTRENGTH=0.65, NOISE=0.35, RGBSEPARATION=0.5, SCANSTRENGTH=0.65
/*
[configuration]
[OptionRangeFloat]
GUIName = Curvature
OptionName = M_CURVATURE
MinValue = 0.0
MaxValue = 1.0
DefaultValue = 0.5
StepAmount = 0.05
[OptionRangeFloat]
GUIName = Scanline speed
OptionName = M_SCAN_SPEED
MinValue = 0.0
MaxValue = 10.0
DefaultValue = 1.0
StepAmount = 0.5
[OptionRangeFloat]
GUIName = Brightness (stops)
OptionName = M_EXPOSURE
MinValue = -2.0
MaxValue = 2.0
DefaultValue = 0.0
StepAmount = 0.1
[/configuration]
*/

// Dolphin supplies src_rect as normalized origin and extent of the valid image.
// GetWindowResolution is the presentation rectangle; GetTargetResolution is
// the complete destination framebuffer and may include letterboxing.
#define iResolution max(GetWindowResolution(), float2(1.0))
#define iTime (float(GetTime()) * 0.001)

float3 sample_(float2 tc)
{
    float2 size = max(GetResolution(), float2(1.0));
    float2 extent = max(src_rect.zw, 1.0 / size);
    float2 position = src_rect.xy + tc * extent;
    // Original Libretro preset requests nearest filtering. Sampling texel
    // centers reproduces it through Dolphin's linear SampleLocation sampler.
    float2 first = floor(src_rect.xy * size);
    float2 last = max(first, ceil((src_rect.xy + extent) * size) - 1.0);
    float2 pixel = clamp(floor(position * size), first, last);
    float3 value = SampleLocation((pixel + 0.5) / size).rgb;
    return pow(max(value, float3(0.0)), float3(2.2));
}

float3 blur(float2 tc, float offs)
{
	float4 xoffs = offs * float4(-2.0, -1.0, 1.0, 2.0) / iResolution.x;
	float4 yoffs = offs * float4(-2.0, -1.0, 1.0, 2.0) / iResolution.y;

	
	float3 color = float3(0.0, 0.0, 0.0);
	color += sample_(tc + float2(xoffs.x, yoffs.x)) * 0.00366;
	color += sample_(tc + float2(xoffs.y, yoffs.x)) * 0.01465;
	color += sample_(tc + float2(    0.0, yoffs.x)) * 0.02564;
	color += sample_(tc + float2(xoffs.z, yoffs.x)) * 0.01465;
	color += sample_(tc + float2(xoffs.w, yoffs.x)) * 0.00366;
	
	color += sample_(tc + float2(xoffs.x, yoffs.y)) * 0.01465;
	color += sample_(tc + float2(xoffs.y, yoffs.y)) * 0.05861;
	color += sample_(tc + float2(    0.0, yoffs.y)) * 0.09524;
	color += sample_(tc + float2(xoffs.z, yoffs.y)) * 0.05861;
	color += sample_(tc + float2(xoffs.w, yoffs.y)) * 0.01465;
	
	color += sample_(tc + float2(xoffs.x, 0.0)) * 0.02564;
	color += sample_(tc + float2(xoffs.y, 0.0)) * 0.09524;
	color += sample_(tc + float2(    0.0, 0.0)) * 0.15018;
	color += sample_(tc + float2(xoffs.z, 0.0)) * 0.09524;
	color += sample_(tc + float2(xoffs.w, 0.0)) * 0.02564;
	
	color += sample_(tc + float2(xoffs.x, yoffs.z)) * 0.01465;
	color += sample_(tc + float2(xoffs.y, yoffs.z)) * 0.05861;
	color += sample_(tc + float2(    0.0, yoffs.z)) * 0.09524;
	color += sample_(tc + float2(xoffs.z, yoffs.z)) * 0.05861;
	color += sample_(tc + float2(xoffs.w, yoffs.z)) * 0.01465;
	
	color += sample_(tc + float2(xoffs.x, yoffs.w)) * 0.00366;
	color += sample_(tc + float2(xoffs.y, yoffs.w)) * 0.01465;
	color += sample_(tc + float2(    0.0, yoffs.w)) * 0.02564;
	color += sample_(tc + float2(xoffs.z, yoffs.w)) * 0.01465;
	color += sample_(tc + float2(xoffs.w, yoffs.w)) * 0.00366;

	return color;
}

//Canonical noise function; replaced to prevent precision errors
//float rand(float2 co){
//    return fract(sin(dot(co.xy ,float2(12.9898,78.233))) * 43758.5453);
//}

float rand(float2 co)
{
    float a = 12.9898;
    float b = 78.233;
    float c = 43758.5453;
    float dt= dot(co.xy ,float2(a,b));
    float sn= mod(dt,3.14);
    return fract(sin(sn) * c);
}

float2 curve(float2 uv)
{
	uv = (uv - 0.5) * 2.0;
	uv *= 1.1;	
	uv.x *= 1.0 + pow((abs(uv.y) / 5.0), 2.0);
	uv.y *= 1.0 + pow((abs(uv.x) / 4.0), 2.0);
	uv  = (uv / 2.0) + 0.5;
	uv =  uv *0.92 + 0.04;
	return uv;
}

void main()
{
    float2 extent = max(src_rect.zw, 1.0 / max(GetResolution(), float2(1.0)));
    float2 q = (GetCoordinates() - src_rect.xy) / extent;
    // Anchor the repeating pattern to the image, independent of black bars.
    float2 fragCoord = floor(q * iResolution) + 0.5;
    float2 geometry = q;
    float2 uv = mix(geometry, curve(geometry), GetOption(M_CURVATURE));
    // Reject outside geometry before evaluating fractional powers.
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0)
    {
        SetOutput(float4(0.0, 0.0, 0.0, 1.0));
        return;
    }
    float3 col;
    float o = 2.0 * mod(fragCoord.y, 2.0) / iResolution.x;
    col.r = 1.0*blur(float2(uv.x+0.0009*0.5,uv.y+0.0009*0.5),1.2*0.8).x+0.005;
    col.g = 1.0*blur(float2(uv.x+0.000,uv.y-0.0015*0.5),1.2*0.8).y+0.005;
    col.b = 1.0*blur(float2(uv.x-0.0015*0.5,uv.y+0.000),1.2*0.8).z+0.005;
    if (0.65 > 0.0)
    {
    col.r += 0.2*0.65*blur(float2(uv.x+0.0009*0.5,uv.y+0.0009*0.5),2.25*1.0).x;
    col.g += 0.2*0.65*blur(float2(uv.x+0.000,uv.y-0.0015*0.5),1.75*1.0).y;
    col.b += 0.2*0.65*blur(float2(uv.x-0.0015*0.5,uv.y+0.000),1.25*1.0).z;
    }
    col -= float3(0.005);
    if (0.3 > 0.0)
    {
    float ghs = 0.05*0.3;
	col.r += ghs*(1.0-0.299)*blur(uv + 1.0*(0.75*float2(0.01, -0.027)+float2(0.001,0.001)),7.0).x;
    col.g += ghs*(1.0-0.587)*blur(uv + 1.0*(0.75*float2(-0.022, -0.02)+float2(0.0,-0.002)),5.0).y;
    col.b += ghs*(1.0-0.114)*blur(uv + 1.0*(0.75*float2(-0.02, -0.0)+float2(-0.002,0.0)),3.0).z;
    
    

    }
    col = clamp(col*0.4+0.6*col*col*1.0,0.0,1.0);
    float vig = (0.0 + 1.0*16.0*uv.x*uv.y*(1.0-uv.x)*(1.0-uv.y));
	vig = pow(max(vig, 0.0),0.3);
	col *= float3(max(0.0, mix(1.0, vig, 1.0)));

    col *= float3(0.95,1.05,0.95);
	col = mix( col, col * col, 0.3) * 3.8;

	float scans = clamp( 0.35+0.15*sin(3.5*(iTime * GetOption(M_SCAN_SPEED) * 1.0)+uv.y*iResolution.y*1.5*1.0), 0.0, 1.0);
	
	float s = pow(scans,0.9);
	col = col*float3(max(0.0, mix(1.0, s, 0.65))) ;

    col *= 1.0+0.0015*1.0*sin(300.0*iTime);
	
	col*=1.0-0.15*0.6*float3(clamp((mod(fragCoord.x+o, 2.0)-1.0)*2.0,0.0,1.0));
	col *= float3( 1.0 ) - 0.25*0.35*float3( rand( uv+0.0001*iTime*1.0),  rand( uv+0.0001*iTime*1.0 + 0.3 ),  rand( uv+0.0001*iTime*1.0+ 0.5 )  );
	col = pow(max(col, float3(0.0)), float3(0.45));

    float luma = dot(col, float3(0.2126, 0.7152, 0.0722));
    col = max(mix(float3(luma), col, 1.0), float3(0.0));
    col *= exp2(GetOption(M_EXPOSURE)) * float3(1.0, 1.0, 1.0);
    SetOutput(float4(col, 1.0));
}
