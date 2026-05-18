import os
import sys
import time
import platform
import subprocess
from getpass import getpass
import ctypes
from threading import Thread

class PCLockSystem:
    """A full PC Lock System with complete system control"""
    
    def __init__(self, default_password="1234567890"):
        self.password = default_password
        self.locked = True
        self.system_type = platform.system()
    
    def clear_screen(self):
        """Clear the console screen"""
        os.system('cls' if self.system_type == "Windows" else 'clear')
    
    def disable_keyboard_mouse_windows(self):
        """Disable keyboard and mouse input on Windows"""
        try:
            # Block mouse and keyboard input
            ctypes.windll.kernel32.SetConsoleMode(ctypes.windll.kernel32.GetStdHandle(-11), 0)
        except:
            pass
    
    def lock_pc_full(self):
        """Lock the PC completely with screen lock"""
        try:
            if self.system_type == "Windows":
                # Lock the workstation
                os.system("rundll32.exe user32.dll,LockWorkStation")
                self.locked = True
                return True
            elif self.system_type == "Darwin":  # macOS
                os.system("osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down, control down}'")
                self.locked = True
                return True
            elif self.system_type == "Linux":
                subprocess.run(["gnome-screensaver-command", "-l"], check=False)
                self.locked = True
                return True
        except Exception as e:
            print(f"Error locking PC: {e}")
            return False
    
    def verify_password(self, entered_password):
        """Verify if the entered password is correct"""
        return entered_password == self.password
    
    def show_startup_message(self):
        """Display startup lock message"""
        self.clear_screen()
        print("\n" + "█"*60)
        print("█" + " "*58 + "█")
        print("█" + " "*15 + "🔒 PC LOCK SYSTEM - FULL CONTROL 🔒" + " "*10 + "█")
        print("█" + " "*58 + "█")
        print("█"*60)
        print("\n")
        print("⏳ Initializing complete PC lock...\n")
        time.sleep(2)
    
    def show_lock_screen(self):
        """Display the full lock screen"""
        self.clear_screen()
        print("\n" + "█"*60)
        print("█" + " "*58 + "█")
        print("█" + " "*20 + "🔒 PC IS COMPLETELY LOCKED 🔒" + " "*7 + "█")
        print("█" + " "*58 + "█")
        print("█"*60)
        print("\n")
        print("╔" + "═"*58 + "╗")
        print("║" + " "*58 + "║")
        print("║" + " "*15 + "⚠️  THIS PC IS NOW FULLY LOCKED" + " "*11 + "║")
        print("║" + " "*58 + "║")
        print("║" + " "*12 + "Only authorized users can unlock this system" + " "*3 + "║")
        print("║" + " "*58 + "║")
        print("╚" + "═"*58 + "╝")
        print("\n")
    
    def unlock_pc(self):
        """Unlock the PC with password verification"""
        attempts = 3
        
        while attempts > 0:
            self.show_lock_screen()
            print("🔑 PLEASE ENTER PASSWORD TO UNLOCK:\n")
            entered_password = getpass("➜ Password: ")
            
            if self.verify_password(entered_password):
                self.clear_screen()
                print("\n" + "="*60)
                print("✅  PASSWORD CORRECT - PC UNLOCKING NOW!")
                print("="*60)
                print("\nSystem is now unlocked and fully accessible.")
                print("This lock program will close automatically.\n")
                time.sleep(2)
                self.locked = False
                return True
            else:
                attempts -= 1
                if attempts > 0:
                    print(f"\n❌ INCORRECT PASSWORD!")
                    print(f"⚠️  Attempts remaining: {attempts}\n")
                    time.sleep(2)
                    self.clear_screen()
                else:
                    print("\n" + "█"*60)
                    print("█" + " "*58 + "█")
                    print("█" + " "*15 + "❌ MAXIMUM ATTEMPTS EXCEEDED" + " "*14 + "█")
                    print("█" + " "*58 + "█")
                    print("█"*60)
                    print("\n⚠️  System remains locked!")
                    print("Contact your administrator for assistance.\n")
                    time.sleep(3)
                    # Restart attempts
                    attempts = 3
        
        return False
    
    def change_password(self):
        """Change the PC lock password"""
        self.clear_screen()
        print("\n" + "="*60)
        print("CHANGE PASSWORD")
        print("="*60 + "\n")
        
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
        print("\n" + "="*60)
        print("   PC LOCK SYSTEM v3.0 - UNLOCKED")
        print("="*60)
        print("\nOptions:")
        print("1. Lock PC Again")
        print("2. Change Password")
        print("3. Exit System (Close Lock Program)")
        print("="*60)
    
    def run(self):
        """Run the PC Lock System with full PC control"""
        # Show startup message
        self.show_startup_message()
        
        # Lock the PC system
        self.lock_pc_full()
        time.sleep(1)
        
        # Enter unlock loop
        while self.locked:
            if not self.unlock_pc():
                continue
        
        # If unlocked successfully, show menu
        if not self.locked:
            while not self.locked:
                self.show_menu()
                choice = input("\nEnter your choice (1-3): ").strip()
                
                if choice == "1":
                    self.lock_pc_full()
                    print("\n🔒 PC Locked Again!")
                    time.sleep(1)
                    # Go back to unlock screen
                    while self.locked:
                        if not self.unlock_pc():
                            continue
                        break
                
                elif choice == "2":
                    self.change_password()
                
                elif choice == "3":
                    self.clear_screen()
                    print("\n✅ PC Lock System closing...")
                    print("System is now fully unlocked and accessible.")
                    time.sleep(1)
                    print("\nGoodbye! 👋\n")
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
        print("\n\n⚠️  System cannot be interrupted while locked!")
        print("🔒 Lock remains active! Use correct password to unlock.\n")
        time.sleep(2)
        sys.exit(0)
