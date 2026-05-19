Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

$Password = "1234" # Change your password here

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Locked"
$Form.BackColor = [System.Drawing.Color]::Black
$Form.WindowState = "Maximized"
$Form.FormBorderStyle = "None"
$Form.TopMost = $true

$Label = New-Object System.Windows.Forms.Label
$Label.Text = "ENTER PASSWORD TO UNLOCK"
$Label.ForeColor = [System.Drawing.Color]::White
$Label.Font = New-Object System.Drawing.Font("Segoe UI", 24)
$Label.Dock = "Top"
$Label.TextAlign = "MiddleCenter"
$Label.Height = 150
$Form.Controls.Add($Label)

$InputBox = New-Object System.Windows.Forms.TextBox
$InputBox.PasswordChar = "*"
$InputBox.Font = New-Object System.Drawing.Font("Segoe UI", 16)
$InputBox.Width = 250
$InputBox.Left = ([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width / 2) - 125
$InputBox.Top = ([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height / 2) - 50
$Form.Controls.Add($InputBox)

$Button = New-Object System.Windows.Forms.Button
$Button.Text = "Unlock"
$Button.Width = 100
$Button.Left = ([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width / 2) - 50
$Button.Top = ([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height / 2) + 20
$Button.ForeColor = [System.Drawing.Color]::Black
$Button.BackColor = [System.Drawing.Color]::White

$Button.Add_Click({
    if ($InputBox.Text -eq $Password) {
        $Form.Close()
    } else {
        [System.Windows.Forms.MessageBox]::Show("Incorrect Password")
        $InputBox.Text = ""
    }
})
$Form.Controls.Add($Button)

$Form.ShowDialog()

