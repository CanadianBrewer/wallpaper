$Source = @" 
		using System;
		using System.Runtime.InteropServices;
		using Microsoft.Win32;

		namespace Wallpaper
		{
			public class UpdateImage
			{
				[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
			
				private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);

				public static void Refresh(string path) 
				{
					SystemParametersInfo( 20, 0, path, 0x01 | 0x02 ); 
				}
			}
		}
"@ 

Add-Type -TypeDefinition $Source -Language CSharp  

$base_url = "http://www.bing.com"
$query_url = $base_url + "/HPImageArchive.aspx?format=js&idx=0&n=1"
$build_info = Invoke-RestMethod -Uri $query_url
$image_url = $base_url + $build_info.images[0].url
$output = "C:\Users\<username>\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($image_url, $output)
[Wallpaper.UpdateImage]::Refresh($output)
