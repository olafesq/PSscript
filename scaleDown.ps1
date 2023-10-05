#Olavi 4.10.2023
#Create Reg Entry: Computer\HKEY_CLASSES_ROOT\*\shell\ScaleDown\command
#Default value: cmd /c start /min "" powershell  -WindowStyle hidden -Command "& C:\Users\olafe\Documents\PSscript\scaleDown.ps1" '%1'

# Import the System.Drawing assembly
Add-Type -AssemblyName System.Drawing

# Function to resize an image with default parameters and custom output filename in JPEG format
function ScaleDown {
    param(
        [string]$inputFile,
        [int]$newWidth = 800   # Default width
    )
	
	Write-Host 'Hello, func'
    # Generate the output filename with "_small" appended and .jpeg extension
    $outputFile = [System.IO.Path]::ChangeExtension($inputFile, "jpeg")
    $outputFile = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($inputFile), "$([System.IO.Path]::GetFileNameWithoutExtension($inputFile))_small.jpeg")

    # Load the image
    $image = [System.Drawing.Image]::FromFile($inputFile)

	# Calculate the new height to maintain the aspect ratio
    $aspectRatio = $image.Width / $image.Height
    $newHeight = [math]::Round($newWidth / $aspectRatio)

    # Create a new bitmap with the desired size
    $newImage = New-Object System.Drawing.Bitmap($newWidth, $newHeight)

    # Create a graphics object to draw the resized image
    $graphics = [System.Drawing.Graphics]::FromImage($newImage)
    $graphics.DrawImage($image, 0, 0, $newWidth, $newHeight)

    # Save the resized image with the custom output filename in JPEG format
    $jpegEncoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.FormatID -eq [System.Drawing.Imaging.ImageFormat]::JPEG.Guid }
    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 90)  # Adjust JPEG quality as needed (0-100)

    $newImage.Save($outputFile, $jpegEncoder, $encoderParams)

    # Clean up
    $image.Dispose()
    $newImage.Dispose()
    $graphics.Dispose()
}

ScaleDown($args[0])
	
