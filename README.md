# 🚀 Vbmeta Verification Disabler

This tool simplifies the process of disabling **vbmeta Verification**—a common requirement when installing Custom Recoveries (TWRP/OrangeFox) or Custom ROMs on Android devices. It patches the image and packages it into a flashable format.

With integrated **GitHub Actions** support, you can generate your patched files directly on the cloud without setting up a local Linux environment.

---

## ✨ Features
* **Auto-Patching**: Utilizes `patch-vbmeta.py` to disable the verification flags in `vbmeta.img`.
* **Flash-Ready**: Automatically compresses the patched image into `lz4` and wraps it in a `.tar` archive for compatibility with various flashing tools. (Samsung Recommend)
* **Flexible Input**: Supports direct download links (URL) or local file paths.
* **Cloud Build**: Fully automated workflow via GitHub Actions.

---

## 🛠 How to Use

### 🟢 Using GitHub Actions (Recommended)
No installation required on your PC.
1.  **Fork** this repository to your Github account.
2.  Navigate to the **Actions** tab at the top of the repository.
3.  Select the **"Patch vbmeta for disable verification"** workflow from the left sidebar.
4.  Click **Run workflow** and enter the direct download link for your `vbmeta.img`.
    * You can upload the recovery and get a direct link from https://filebin.net/
5.  Once the process is finished, download the `Patched-disabled-vbmeta` file from the **Artifacts** section.

### 🟢 Running Locally
Requires an Ubuntu or WSL (Windows Subsystem for Linux) environment.

```bash
# Clone the repository
git clone https://github.com/GoRhanHee/vbmeta-disable-verification.git
cd vbmeta-disable-verification

# Grant execution permissions
chmod +x vbmeta.sh patch-vbmeta.py

# Run the script with the path to your vbmeta file
./vbmeta.sh /path/to/your/vbmeta.img
```

---

## Credits
vbmeta-disable-verification [@libzxr](https://github.com/libxzr/vbmeta-disable-verification)

patch-vbmeta.py [@WessellUrdata](https://github.com/WessellUrdata/vbmeta-disable-verification?tab=readme-ov-file)

vbmeta.sh [@ravindu644](https://github.com/ravindu644/patch-recovery-revived) (from idea)

and developer by [@GoRhanHee](https://github.com/GoRhanHee/vbmeta-disable-verification)