import os
import sys
import time
import platform
import subprocess
from getpass import getpass

class PCLockSystem:
    """A full PC Lock System with auto-lock and greeting"""
    
    def __init__(self, default_password="1234567890"):
        self.password = default_password
        self.locked = True  # Start locked immediately
        self.system_type = platform.system()
    
    def clear_screen(self):
        """Clear the console screen"""
        os.system('cls' if self.system_type == "Windows" else 'clear')
    
    def lock_pc(self):
        """Lock the PC based on the operating system"""
        try:
            if self.system_type == "Windows":
                os.system("rundll32.exe user32.dll,LockWorkStation")
            elif self.system_type == "Darwin":  # macOS
                os.system("osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down, control down}'")
            elif self.system_type == "Linux":
                subprocess.run(["gnome-screensaver-command", "-l"], check=False)
            self.locked = True
            return True
        except Exception as e:
            print(f"✗ Error locking PC: {e}")
            return False
    
    def verify_password(self, entered_password):
        """Verify if the entered password is correct"""
        return entered_password == self.password
    
    def show_greeting(self):
        """Display the greeting screen"""
        self.clear_screen()
        print("\n" + "█"*50)
        print("█" + " "*48 + "█")
        print("█" + " "*15 + "Hello 👋  PC LOCK SYSTEM" + " "*9 + "█")
        print("█" + " "*48 + "█")
        print("█"*50)
        print("\n")
    
    def show_lock_screen(self):
        """Display the full lock screen"""
        self.show_greeting()
        print("🔒 " + "="*45 + " 🔒")
        print("║")
        print("║   This PC is now LOCKED and FULLY BLOCKED")
        print("║   ")
        print("║   ⚠️  Only authorized users can unlock this system")
        print("║")
        print("║   🔐 Password Required to Continue")
        print("║")
        print("🔒 " + "="*45 + " 🔒\n")
    
    def unlock_pc(self):
        """Unlock the PC with password verification"""
        attempts = 3
        
        while attempts > 0:
            self.show_lock_screen()
            entered_password = getpass("🔑 Enter password to unlock PC: ")
            
            if self.verify_password(entered_password):
                self.clear_screen()
                print("\n" + "="*50)
                print("✅  PASSWORD CORRECT! PC UNLOCKED SUCCESSFULLY!")
                print("="*50 + "\n")
                time.sleep(2)
                self.locked = False
                return True
            else:
                attempts -= 1
                if attempts > 0:
                    print(f"\n❌ Incorrect password! Attempts remaining: {attempts}\n")
                    time.sleep(2)
                    self.clear_screen()
                else:
                    print("\n❌ Maximum attempts exceeded! System will remain locked.")
                    print("Contact your administrator.\n")
                    time.sleep(2)
        
        return False
    
    def change_password(self):
        """Change the PC lock password"""
        self.clear_screen()
        print("\n" + "="*50)
        print("CHANGE PASSWORD")
        print("="*50 + "\n")
        
        current_password = getpass("Enter current password: ")
        
        if not self.verify_password(current_password):
            print("\n❌ Incorrect current password!")
            time.sleep(2)
            return False
        
        new_password = getpass("Enter new password: ")
        confirm_password = getpass("Confirm new password: ")
        
        if new_password == confirm_password:
            self.password = new_password
            print("\n✅ Password changed successfully!")
            time.sleep(2)
            return True
        else:
            print("\n❌ Passwords do not match!")
            time.sleep(2)
            return False
    
    def show_menu(self):
        """Display the menu for unlocked state"""
        self.clear_screen()
        print("\n" + "="*50)
        print("   PC LOCK SYSTEM v2.0 - UNLOCKED")
        print("="*50)
        print("\nOptions:")
        print("1. Lock PC Again")
        print("2. Change Password")
        print("3. Exit")
        print("="*50)
    
    def run(self):
        """Run the PC Lock System with auto-lock on startup"""
        # Show greeting and lock immediately
        self.show_greeting()
        print("⏳ PC Locked! Initializing full lock system...\n")
        time.sleep(2)
        self.lock_pc()
        time.sleep(1)
        
        # Enter unlock loop
        while True:
            if self.locked:
                if not self.unlock_pc():
                    # Keep trying until password is correct
                    continue
            
            # If unlocked, show menu options
            while not self.locked:
                self.show_menu()
                choice = input("\nEnter your choice (1-3): ").strip()
                
                if choice == "1":
                    self.lock_pc()
                    print("\n🔒 PC Locked Again!")
                    time.sleep(1)
                    break  # Go back to unlock screen
                
                elif choice == "2":
                    self.change_password()
                
                elif choice == "3":
                    self.clear_screen()
                    print("\n✅ Exiting PC Lock System. Goodbye!")
                    time.sleep(1)
                    sys.exit(0)
                
                else:
                    print("\n❌ Invalid choice! Please try again.")
                    time.sleep(1)


if __name__ == "__main__":
    try:
        # Create and run the PC Lock System
        # Change default password here if needed
        lock_system = PCLockSystem(default_password="1234567890")
        lock_system.run()
    except KeyboardInterrupt:
        print("\n\n⚠️  System interrupt detected. Lock remains active!")
        sys.exit(0)
