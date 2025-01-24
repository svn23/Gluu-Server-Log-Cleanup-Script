🧹 Gluu Server Log Cleanup Script
📄 Overview
This Bash script is designed to help manage log files for Gluu Server by:

🗑️ Removing old log files from specified directories.
🔒 Protecting critical logs essential for system functionality.
⚡ Optimizing storage space usage through automated cleanup.
✨ Features
📂 Customizable Directories: Define which directories to monitor for old logs.
⏳ Time-Based Deletion: Automatically delete files older than a specified time threshold (default: 15 days).
🚫 Critical Log Protection: Ensures essential logs like oxauth.log and oxtrust.log are preserved.
⚙️ Requirements
🖥️ Linux/Unix-based system with Bash.
✅ Permissions to access and delete log files.
🚀 How to Use
1. Clone the Repository
bash

git clone https://github.com/svn23/Gluu-Server-Log-Cleanup-Script.git
cd gluu-log-cleanup
2. Edit the Script
Open the script to configure log directories:

bash

nano log_cleanup.sh
Replace placeholders like /var/log/oxauth with the actual directory paths.

3. Make the Script Executable
bash

chmod +x log_cleanup.sh
4. Run the Script (Optional Test)
bash

./log_cleanup.sh
5. Schedule via Cron
To automate the cleanup, add the script to cron:

bash

crontab -e
Add this line to execute daily at 2 AM:

bash

0 2 * * * /path/to/log_cleanup.sh
🔑 Highlights
🛠️ Directories: Fully customizable list of directories to monitor.
⏱️ Time Threshold: Easily configurable in the script (default: 15 days).
🔐 Static Log Protection: Safeguards critical logs from deletion.
📦 File Structure
bash

/gluu-log-cleanup  
├── log_cleanup.sh  # Main cleanup script  
├── README.md       # Documentation file  
🙋‍♂️ Contributing
Feel free to:

Report issues 🐛
Submit pull requests 🚀
Suggest enhancements 💡
📝 License
This project is owned by Sovan Sundar Sen. All rights reserved. 🏷️
Please contact for permissions or inquiries.

📷 Screenshots
Add relevant screenshots or terminal outputs here to demonstrate the script in action.

💻 Made with ❤️ by Sovan Sundar Sen