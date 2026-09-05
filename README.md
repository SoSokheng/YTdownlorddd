# ⚡ YT DOWNLOADER GANG [CMD Edition] ⚡

A high-speed, portable, zero-setup YouTube Video & Audio Downloader engineered with a retro CMD / Hacker aesthetic. Built directly for Windows batch (`.bat`) with automated dependency bootstrapping.

---

## 🚀 Quick Start

1. **Launch the tool**: Double-click [`YT_DOWNLOADER_GANG.bat`](file:///C:/Users/noobk/.gemini/antigravity-ide/scratch/yt-downloader-gang/YT_DOWNLOADER_GANG.bat).
2. **First Run Setup (Automated)**:
   - On first run on a new PC, the tool auto-detects if `yt-dlp` and `FFmpeg` are present.
   - If not found, it provides a 1-click auto-installer that downloads portable standalone binaries into the local `bin\` folder in seconds!
   - **No admin privileges required.**
3. **Download**: Choose an option (MP4 or MP3), paste your YouTube URL, and hit `Enter`!
4. **Output**: Your downloaded files will be saved in the [`Downloads\`](file:///C:/Users/noobk/.gemini/antigravity-ide/scratch/yt-downloader-gang/Downloads) folder.

---

## ✨ Features & Capabilities

| Option | Feature | Description |
|---|---|---|
| **[1]** | **MP4 Best Quality** | Fetches the highest available resolution (4K, 2K, 1080p 60FPS) and automatically merges the best video & audio into a standard `.mp4` with thumbnail & chapter tags. |
| **[2]** | **MP4 Balanced (1080p)** | Ideal for fast downloads with balanced file size, capped at standard 1080p/720p. |
| **[3]** | **MP3 Music (320kbps)** | Extracts high-fidelity audio, converts to `.mp3`, and embeds high-res album artwork and metadata tags. |
| **[4]** | **M4A Audio (Fast)** | Ultra-fast direct audio stream extraction without re-encoding. |
| **[5]** | **Playlist Batch Downloader** | Downloads complete YouTube playlists into automatically named subfolders, with clean numeric indexing (`01 - Title`, `02 - Title`). Choose MP4 or MP3. |
| **[6]** | **Custom Format Inspector** | Inspects all video/audio streams available on YouTube servers and lets you specify the exact format code. |
| **[7]** | **Open Downloads Folder** | Immediately opens the `Downloads\` directory in Windows File Explorer. |
| **[8]** | **Update Core Engine** | Runs `yt-dlp -U` to update the core downloader engine when YouTube modifies its algorithms. |
| **[9]** | **Theme Customizer** | Switch on-the-fly between 6 retro terminal color schemes: Matrix Green, Cyber Cyan, Crimson Red, Synthwave Purple, Retro Amber, or Clean White. |

---

## 📁 Project Directory Structure

```
yt-downloader-gang/
├── YT_DOWNLOADER_GANG.bat    # Standalone double-clickable CMD launcher
├── README.md                 # Complete user guide and documentation
├── bin/                      # Core engine folder (yt-dlp.exe, ffmpeg.exe, ffprobe.exe, banner.txt)
└── Downloads/                # Default destination for all downloaded MP4 & MP3 files
```

---

## 💡 Portability (Support for Any PC)

- You can copy or move this entire `yt-downloader-gang` folder onto a **USB flash drive** or any other Windows 10/11 PC.
- Even if you only copy `YT_DOWNLOADER_GANG.bat` to a blank folder on another machine, running it will automatically bootstrap the required engines into `bin\` seamlessly!

---

## 🛠 Troubleshooting

- **YouTube changed something and downloads are failing?**
  - Choose Option **[8] Update Core Engine** from the main menu to pull the latest `yt-dlp` updates.
- **Where are my downloaded files?**
  - Choose Option **[7] Open Downloads Folder** to instantly open the folder in Windows File Explorer.
