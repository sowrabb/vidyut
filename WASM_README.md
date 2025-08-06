# Vidyut - Flutter WebAssembly (WASM) Build

This document explains how to build and deploy the Vidyut electrical marketplace app as a Flutter WebAssembly application.

## Prerequisites

- Flutter SDK 3.24.0 or higher
- Dart SDK 3.4.0 or higher
- A modern web browser with WebAssembly support

## Building for WebAssembly

### Quick Build
Run the provided build script:
```bash
./build_wasm.sh
```

### Manual Build
If you prefer to build manually:

1. Clean the project:
```bash
flutter clean
```

2. Get dependencies:
```bash
flutter pub get
```

3. Build for WebAssembly:
```bash
flutter build web --web-renderer canvaskit --dart-define=FLUTTER_WEB_USE_SKIA=true --release
```

## Serving the Application

### Local Development
After building, serve the app locally:
```bash
cd build/web
python3 -m http.server 8000
```
Then open http://localhost:8000 in your browser.

### Production Deployment
The built files are in `build/web/` directory. You can deploy these files to any static web hosting service:

- **Netlify**: Drag and drop the `build/web` folder
- **Vercel**: Connect your repository and set build output to `build/web`
- **GitHub Pages**: Push the `build/web` contents to a GitHub Pages branch
- **AWS S3**: Upload the files to an S3 bucket configured for static website hosting

## Key Features of WASM Build

1. **Performance**: WebAssembly provides near-native performance
2. **Cross-platform**: Runs on any modern browser
3. **Offline capability**: Can work offline with proper caching
4. **Smaller bundle size**: Compared to traditional JavaScript builds

## Browser Compatibility

The app requires browsers with WebAssembly support:
- Chrome 57+
- Firefox 52+
- Safari 11+
- Edge 16+

## Troubleshooting

### Build Issues
- Ensure you have the latest Flutter SDK
- Run `flutter doctor` to check for issues
- Clear Flutter cache: `flutter clean`

### Runtime Issues
- Check browser console for WebAssembly errors
- Ensure HTTPS is used for production (WASM requires secure context)
- Verify browser supports WebAssembly

## Performance Optimization

The WASM build includes several optimizations:
- CanvasKit renderer for better graphics performance
- Release mode compilation
- Optimized asset loading
- Service worker for caching

## File Structure After Build

```
build/web/
├── canvaskit/          # CanvasKit WASM files
├── flutter.js          # Flutter runtime
├── flutter_bootstrap.js # Bootstrap script
├── index.html          # Main HTML file
├── main.dart.js        # Compiled Dart code
└── assets/             # App assets
```

## Development Workflow

1. Make changes to your Flutter code
2. Run `./build_wasm.sh` to rebuild
3. Test locally with `python3 -m http.server 8000`
4. Deploy to your hosting platform

## Notes

- The first load may be slower due to WASM compilation
- Subsequent loads will be faster due to browser caching
- The app works offline once loaded
- All Flutter features are supported in WASM mode 