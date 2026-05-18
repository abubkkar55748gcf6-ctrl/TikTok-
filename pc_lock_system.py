import os
import sys
import time
import platform
import subprocess
from getpass import getpass

class PCLockSystem:
    """A simple PC Lock System with password protection"""
    
    def __init__(self, default_password="1234567890"):
        self.password = default_password
        self.locked = False
        self.system_type = platform.system()
    
    def lock_pc(self):
        """Lock the PC based on the operating system"""
        try:
            if self.system_type == "Windows":
                os.system("rundll32.exe user32.dll,LockWorkStation")
                print("✓ PC Locked Successfully!")
            elif self.system_type == "Darwin":  # macOS
                os.system("osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down, control down}'")
                print("✓ PC Locked Successfully!")
            elif self.system_type == "Linux":
                subprocess.run(["gnome-screensaver-command", "-l"], check=False)
                print("✓ PC Locked Successfully!")
            self.locked = True
            return True
        except Exception as e:
            print(f"✗ Error locking PC: {e}")
            return False
    
    def verify_password(self, entered_password):
        """Verify if the entered password is correct"""
        return entered_password == self.password
    
    def unlock_pc(self):
        """Unlock the PC with password verification"""
        attempts = 3
        while attempts > 0:
            entered_password = getpass("Enter password to unlock PC: ")
            
            if self.verify_password(entered_password):
                print("✓ Password correct! PC Unlocked!")
                self.locked = False
                return True
            else:
                attempts -= 1
                print(f"✗ Incorrect password! Attempts remaining: {attempts}")
                time.sleep(1)
        
        print("✗ Maximum attempts exceeded! System will remain locked.")
        return False
    
    def change_password(self):
        """Change the PC lock password"""
        current_password = getpass("Enter current password: ")
        
        if not self.verify_password(current_password):
            print("✗ Incorrect current password!")
            return False
        
        new_password = getpass("Enter new password: ")
        confirm_password = getpass("Confirm new password: ")
        
        if new_password == confirm_password:
            self.password = new_password
            print("✓ Password changed successfully!")
            return True
        else:
            print("✗ Passwords do not match!")
            return False
    
    def show_menu(self):
        """Display the main menu"""
        print("\n" + "="*40)
        print("   PC LOCK SYSTEM v1.0")
        print("="*40)
        if self.locked:
            print("Status: 🔒 LOCKED")
        else:
            print("Status: 🔓 UNLOCKED")
        print("\nOptions:")
        print("1. Lock PC")
        print("2. Unlock PC")
        print("3. Change Password")
        print("4. Exit")
        print("="*40)
    
    def run(self):
        """Run the PC Lock System"""
        print("\n✓ PC Lock System Started!")
        print("Default Password: 1234567890\n")
        
        while True:
            self.show_menu()
            choice = input("\nEnter your choice (1-4): ").strip()
            
            if choice == "1":
                if not self.locked:
                    self.lock_pc()
                else:
                    print("✗ PC is already locked!")
            
            elif choice == "2":
                if self.locked:
                    self.unlock_pc()
                else:
                    print("✗ PC is not locked!")
            
            elif choice == "3":
                self.change_password()
            
            elif choice == "4":
                print("\n✓ Exiting PC Lock System. Goodbye!")
                sys.exit(0)
            
            else:
                print("✗ Invalid choice! Please try again.")
            
            time.sleep(1)


if __name__ == "__main__":
    # Create and run the PC Lock System
    lock_system = PCLockSystem(default_password="1234567890")
    lock_system.run()
