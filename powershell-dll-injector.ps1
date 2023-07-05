# Load Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create a new form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Moon PS Injector" # Rename the form title
$form.Size = New-Object System.Drawing.Size(400,300) # Increase the form size
$form.BackColor = [System.Drawing.Color]::DarkSlateGray # Change the form background color
$form.ForeColor = [System.Drawing.Color]::White # Change the form text color

# Create a button to execute the DLL file
$button = New-Object System.Windows.Forms.Button
$button.Text = "Inject"
$button.Location = New-Object System.Drawing.Point(150,150)
$button.Size = New-Object System.Drawing.Size(100,30)
$button.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat # Make the button flat
$button.BackColor = [System.Drawing.Color]::DarkOrange # Change the button background color
$button.ForeColor = [System.Drawing.Color]::Black # Change the button text color
$button.Add_Click({
    # Check if a DLL file is selected
    if ($textbox.Text -ne "") {
        # Invoke the DLL file using rundll32.exe
        Start-Process rundll32.exe -ArgumentList $textbox.Text
    }
    else {
        # Show a message box if no DLL file is selected
        [System.Windows.Forms.MessageBox]::Show("Please select a DLL file first.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

# Create a button to select a DLL file
$openButton = New-Object System.Windows.Forms.Button
$openButton.Text = "Select File"
$openButton.Location = New-Object System.Drawing.Point(300,100)
$openButton.Size = New-Object System.Drawing.Size(75,25)
$openButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat # Make the button flat
$openButton.BackColor = [System.Drawing.Color]::DarkOrange # Change the button background color
$openButton.ForeColor = [System.Drawing.Color]::Black # Change the button text color
$openButton.Add_Click({
    # Create an open file dialog
    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.Filter = "DLL files (*.dll)|*.dll"
    $openFileDialog.Title = "Select a DLL file"

    # Show the open file dialog and get the result
    $result = $openFileDialog.ShowDialog()

    # If the user clicked OK, update the text box with the file name
    if ($result -eq "OK") {
        $textbox.Text = $openFileDialog.FileName
    }
})

# Create a text box to display the selected DLL file name
$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Point(25,100)
$textbox.Size = New-Object System.Drawing.Size(250,25)
$textbox.ReadOnly = $true

# Add the controls to the form
$form.Controls.Add($button)
$form.Controls.Add($openButton)
$form.Controls.Add($textbox)

# Show the form
$form.ShowDialog()
