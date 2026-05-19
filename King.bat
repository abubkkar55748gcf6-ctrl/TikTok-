Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Runtime.InteropServices

$Password = "1234" # Change your password here

# Block system keys (Ctrl+Alt+Del, Alt+Tab, Windows key, etc.)
$signature = @"
[DllImport("user32.dll", SetLastError = true)]
public static extern bool RegisterHotKey(IntPtr hWnd, int id, uint fsModifiers, uint vk);

[DllImport("user32.dll", SetLastError = true)]
public static extern bool UnregisterHotKey(IntPtr hWnd, int id);
"@
Add-Type -MemberDefinition $signature -Name "Win32" -Namespace Win32Functions

# Disable Alt+Tab
$null = [Win32Functions.Win32]::RegisterHotKey([IntPtr]::Zero, 1, 3, 9) # Alt+Tab

# Disable Windows Key
$null = [Win32Functions.Win32]::RegisterHotKey([IntPtr]::Zero, 2, 0, 91) # Windows Key

# Create Form
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "System Locked"
$Form.BackColor = [System.Drawing.Color]::Black
$Form.WindowState = "Maximized"
$Form.FormBorderStyle = "None"
$Form.TopMost = $true
$Form.ControlBox = $false
$Form.MaximizeBox = $false
$Form.MinimizeBox = $false

# Hide taskbar
$hideTaskbarCode = @"
[DllImport("user32.dll")]
public static extern int FindWindow(string className, string windowTitle);
[DllImport("user32.dll")]
public static extern int ShowWindow(int hwnd, int command);
public const int SW_HIDE = 0;
public const int SW_SHOW = 5;
"@
Add-Type -MemberDefinition $hideTaskbarCode -Name Win32ShowWindowAPI -Namespace Win32

$taskbarHandle = [Win32.Win32ShowWindowAPI]::FindWindow("Shell_traywnd", "")
if ($taskbarHandle -gt 0) {
    [Win32.Win32ShowWindowAPI]::ShowWindow($taskbarHandle, 0) | Out-Null
}

# Title Label
$Label = New-Object System.Windows.Forms.Label
$Label.Text = "SYSTEM LOCKED`nENTER PASSWORD TO UNLOCK"
$Label.ForeColor = [System.Drawing.Color]::White
$Label.Font = New-Object System.Drawing.Font("Segoe UI", 32, [System.Drawing.FontStyle]::Bold)
$Label.Dock = "Top"
$Label.TextAlign = "MiddleCenter"
$Label.Height = 200
$Form.Controls.Add($Label)

# Password Input
$InputBox = New-Object System.Windows.Forms.TextBox
$InputBox.PasswordChar = "*"
$InputBox.Font = New-Object System.Drawing.Font("Segoe UI", 18)
$InputBox.Width = 300
$InputBox.Left = ([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width / 2) - 150
$InputBox.Top = ([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height / 2) - 80
$InputBox.Height = 40
$InputBox.BackColor = [System.Drawing.Color]::White
$Form.Controls.Add($InputBox)

# Unlock Button
$Button = New-Object System.Windows.Forms.Button
$Button.Text = "UNLOCK"
$Button.Width = 150
$Button.Height = 45
$Button.Left = ([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width / 2) - 75
$Button.Top = ([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height / 2) + 20
$Button.ForeColor = [System.Drawing.Color]::White
$Button.BackColor = [System.Drawing.Color]::Red
$Button.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)

$Button.Add_Click({
    if ($InputBox.Text -eq $Password) {
        # Show taskbar again
        $taskbarHandle = [Win32.Win32ShowWindowAPI]::FindWindow("Shell_traywnd", "")
        if ($taskbarHandle -gt 0) {
            [Win32.Win32ShowWindowAPI]::ShowWindow($taskbarHandle, 5) | Out-Null
        }
        
        # Unregister hotkeys
        [Win32Functions.Win32]::UnregisterHotKey([IntPtr]::Zero, 1) | Out-Null
        [Win32Functions.Win32]::UnregisterHotKey([IntPtr]::Zero, 2) | Out-Null
        
        $Form.Close()
    } else {
        [System.Windows.Forms.MessageBox]::Show("Incorrect Password!", "Access Denied", "OK", "Error") | Out-Null
        $InputBox.Text = ""
        $InputBox.Focus()
    }
})
$Form.Controls.Add($Button)

# Block closing the form
$Form.Add_FormClosing({
    param($sender, $e)
    if ($e.CloseReason -ne [System.Windows.Forms.CloseReason]::ApplicationExitCall) {
        $e.Cancel = $true
    }
})

# Block all key presses except in the textbox
$Form.Add_KeyDown({
    param($sender, $e)
    if ($InputBox.Focused) {
        if ($e.KeyCode -eq [System.Windows.Forms.Keys]::Enter) {
            $Button.PerformClick()
            $e.Handled = $true
        }
    } else {
        $e.Handled = $true
        $e.SuppressKeyUp = $true
    }
})

$InputBox.Focus()
$Form.ShowDialog()
