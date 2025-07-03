# AD-Entra-Hybrid-Lab
Windows Server 2019 Active Directory lab with Azure Entra ID hybrid sync using PowerShell, GPO, and Azure AD Connect.


# Hybrid Active Directory + Entra ID Lab

This project began as a personal lab to learn on-prem Active Directory, based on [Josh Madakor's YouTube tutorial](https://www.youtube.com/watch?v=MHsI8hJmggI). It evolved into a full hybrid identity setup using Microsoft Entra ID and Azure AD Connect. I implemented a real-world domain sync, resolved domain verification issues, and manually configured the sync between on-prem and cloud identities.

---

## 📚 What This Lab Covers

- Windows Server 2019 installation and AD DS setup
- PowerShell automation to create 1,000 users and multiple OUs
- DHCP and DNS configuration
- Domain join for two client machines (VirtualBox)
- Group Policy creation and enforcement (password complexity, lock screen timeout)
- Azure domain verification via GoDaddy DNS
- Installing and configuring Microsoft Entra Connect
- User sync to Microsoft Entra ID

---

## 🖥️ Lab Environment

| Component     | Detail                        |
|---------------|-------------------------------|
| Virtualization | VirtualBox                   |
| Domain         | IDSentinelSolutions.com      |
| VMs            | 1 AD DC, 1 Entra Connect, 2 Clients |
| OS             | Windows Server 2019, Windows 10        |
| Cloud          | Microsoft Entra ID (Azure AD) |

---

## 🔧 Tools Used

- PowerShell
- Active Directory Domain Services (AD DS)
- DHCP / DNS Server Roles
- Group Policy Management Console (GPMC)
- Microsoft Entra Connect
- Microsoft Entra Admin Center
- GoDaddy DNS

---

## 🧪 Lab Setup & Steps

### ✅ Phase 1: On-Prem AD Setup

- Installed Windows Server 2019
- Added AD DS, DHCP, and DNS server roles
- Promoted to Domain Controller with internal domain
- Created 1,000 users with PowerShell
- Built OUs for departments, devices, locations (IT, HR, etc.)
- Applied GPOs: lock screen timeout, password complexity
- Domain-joined two Windows 10 clients via VirtualBox

### 🔁 Phase 2: Hybrid Identity with Entra ID

- Ran into domain verification issues (original test domain couldn’t sync)
- Purchased a real domain: `IDSentinelSolutions.com` via GoDaddy
- Configured DNS TXT record and verified in Microsoft Entra
- Created a new AD environment with the verified domain
- Installed and configured Entra Connect on a separate VM
- Successfully synced AD users to Entra ID cloud environment

---

## 🔄 Lab Evolution & Lessons Learned

Initially, I set up a lab using a made-up domain for Active Directory testing. After getting DHCP, DNS, users, and clients working, I planned to sync with Azure but hit a roadblock: **Azure AD Connect requires domain ownership verification**, and my original test domain couldn't be verified.

### What I did to fix it:
- Registered a real domain: `IDSentinelSolutions.com`
- Verified the domain in Microsoft Entra (Azure AD)
- Rebuilt the AD lab environment using the verified domain
- Configured Azure AD Connect manually and completed sync

### What I learned:
- How UPN suffixes and verified domains impact hybrid identity
- How to set up AD for real-world use, not just isolated labs
- That troubleshooting sync issues requires understanding DNS, UPNs, and Azure identity architecture
- The importance of using real scenarios to gain hands-on experience

---

## 💡 What I Added Beyond the Video

- Used a **real, owned domain** and updated DNS for Azure verification
- Rebuilt a full AD environment to support verified sync
- Configured and verified Azure AD Connect manually
- Connected two Windows 10 clients and tested AD policies
- Planning to add Conditional Access and SSPR as next steps

---

## 📁 Scripts

- [CreateUsers.ps1](./scripts/CreateUsers.ps1) - Creates users in bulk from names.txt
- [Create_HybridOUs.ps1](./scripts/Create_HybridOUs.ps1) - Creates a hybrid OU structure for role separation
- [Create_Security_Tier_GPOs.ps1](./scripts/Create_Security_Tier_GPOs.ps1) - Builds GPOs for security tiering
- [Create_and_link_GPOs.ps1](./scripts/Create_and_link_GPOs.ps1) - Links GPOs to OUs
- [names.txt](./scripts/names.txt) - Source file containing user first/last names

---

## 📸 Screenshots

| Description                     | Image |
|---------------------------------|-------|
| AD DS Setup                     | ![](./Screenshots/AD%20DS%20Setup.png) |
| DNS & DHCP Configuration        | ![](./Screenshots/DNS-DHCP%20Config.png) |
| GPMC with GPOs Applied          | ![](./Screenshots/GPMC%20with%20GPOs.png) |
| Azure Domain Verification       | ![](./Screenshots/Azure%20Domain%20Verification.png) |
| Entra Connect Sync Complete     | ![](./Screenshots/Entra%20Connect%20Sync.png) |
| Users Synced to Entra ID        | ![](./Screenshots/Users%20Synced%20to%20Entra%20ID.png) |

---

## 🔗 Links

- [Josh Madakor's YouTube Tutorial](https://www.youtube.com/watch?v=MHsI8hJmggI)
- [My LinkedIn](https://www.linkedin.com/in/cleveland-oliver-iamsecurity/)
- [My Website](https://www.IDSentinelSolutions.com)

---

## 🚧 Coming Soon

- Conditional Access: MFA requirement off trusted networks
- Self-Service Password Reset (SSPR) with on-prem writeback
- Audit logging and Defender for Identity integration
