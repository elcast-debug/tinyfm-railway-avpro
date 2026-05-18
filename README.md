# Tiny File Manager on Railway for VRChat AVPro

Railway-ready Tiny File Manager setup that serves uploaded MP4 files from direct public URLs under `/uploads/...` with nginx in front of PHP-FPM.

## Why this works for AVPro / VRChat

- Direct file URLs like `https://your-app.up.railway.app/uploads/video.mp4`
- Static MP4 delivery from nginx instead of PHP download streaming
- `Accept-Ranges: bytes` header for seek-friendly playback
- `video/mp4` MIME type
- FFmpeg helper for `-movflags +faststart`

## Deploy to Railway

1. Create a new GitHub repo and upload this project.
2. Create a Railway project from that repo.
3. Add env var `TFM_ADMIN_PASSWORD_HASH` with a bcrypt hash.
4. Deploy.

## Generate password hash

Use PHP locally:

```bash
php -r "echo password_hash('yourStrongPassword', PASSWORD_BCRYPT), PHP_EOL;"
```

Then paste that into Railway variable `TFM_ADMIN_PASSWORD_HASH`.

## Upload videos

- Open `/`
- Log in to Tiny File Manager
- Upload MP4s into `uploads/`
- Use direct links like `/uploads/filename.mp4` in VRChat

## Faststart optimization

If a file was uploaded without faststart metadata, run inside the container:

```bash
optimize-mp4.sh /var/www/public/uploads/yourvideo.mp4
```

That rewrites the MP4 so metadata is placed at the front, which helps progressive playback and seeking.

## Important VRChat note

If your domain is not trusted by VRChat, users may need to enable **Allow Untrusted URLs** in VRChat.

## Suggested future improvement

If you want auto-faststart on every upload, the next step is patching Tiny File Manager upload handling to call `optimize-mp4.sh` automatically after MP4 upload.
