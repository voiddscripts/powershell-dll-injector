Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = "Moon PS Injector"
$form.Size = New-Object System.Drawing.Size(400,300)
$form.BackColor = [System.Drawing.Color]::DarkSlateGray
$form.ForeColor = [System.Drawing.Color]::White

$button = New-Object System.Windows.Forms.Button
$button.Text = "Inject"
$button.Location = New-Object System.Drawing.Point(150,150)
$button.Size = New-Object System.Drawing.Size(100,30)
$button.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$button.BackColor = [System.Drawing.Color]::DarkOrange
$button.ForeColor = [System.Drawing.Color]::Black
$button.Add_Click({
    if ($textbox.Text -ne "") {
        Start-Process rundll32.exe -ArgumentList $textbox.Text
    }
    else {
        [System.Windows.Forms.MessageBox]::Show("Please select a DLL file first.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

$openButton = New-Object System.Windows.Forms.Button
$openButton.Text = "Select File"
$openButton.Location = New-Object System.Drawing.Point(300,100)
$openButton.Size = New-Object System.Drawing.Size(75,25)
$openButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$openButton.BackColor = [System.Drawing.Color]::DarkOrange
$openButton.ForeColor = [System.Drawing.Color]::Black
$openButton.Add_Click({
    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.Filter = "DLL files (*.dll)|*.dll"
    $openFileDialog.Title = "Select a DLL file"

    $result = $openFileDialog.ShowDialog()

    if ($result -eq "OK") {
        $textbox.Text = $openFileDialog.FileName
    }
})

$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Point(25,100)
$textbox.Size = New-Object System.Drawing.Size(250,25)
$textbox.ReadOnly = $true

$form.Controls.Add($button)
$form.Controls.Add($openButton)
$form.Controls.Add($textbox)

$form.ShowDialog()
