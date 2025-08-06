# Offline Testing Guide for Vidyut WASM App

## 🚀 Quick Start - Test Offline First

Your WASM Flutter app is now running at: **http://localhost:8000**

## 📋 Step-by-Step Offline Testing

### Step 1: Initial Load (Online)
1. Open your browser and go to **http://localhost:8000**
2. Wait for the app to fully load (you'll see the loading indicator)
3. Navigate through different sections:
   - Home screen
   - Search functionality
   - Product categories
   - Product details
   - Profile section

### Step 2: Test Offline Functionality
1. **Disconnect from internet** (turn off WiFi or use browser dev tools)
2. **Refresh the page** - the app should still work!
3. **Test these features while offline:**
   - ✅ Navigation between screens
   - ✅ Viewing product categories
   - ✅ Browsing product listings
   - ✅ Viewing product details
   - ✅ Profile information
   - ✅ App UI and interactions

### Step 3: Verify Service Worker
1. Open browser DevTools (F12)
2. Go to **Application** tab
3. Click on **Service Workers** in the left sidebar
4. You should see a service worker registered for your app
5. Check the **Cache Storage** section to see cached assets

## 🔧 Browser DevTools for Offline Testing

### Chrome/Edge:
1. Open DevTools (F12)
2. Go to **Network** tab
3. Check **"Offline"** checkbox
4. Refresh the page - app should still work!

### Firefox:
1. Open DevTools (F12)
2. Go to **Network** tab
3. Click the **"Offline"** button
4. Refresh the page

### Safari:
1. Open DevTools (Develop menu)
2. Go to **Network** tab
3. Check **"Offline"** checkbox

## 📱 Testing on Mobile Devices

### Local Network Testing:
1. Find your computer's IP address:
   ```bash
   ifconfig | grep "inet " | grep -v 127.0.0.1
   ```
2. On your mobile device, go to: `http://[YOUR_IP]:8000`
3. Test offline functionality by turning off mobile data/WiFi

### Progressive Web App (PWA) Testing:
1. On mobile, the app should show an "Add to Home Screen" prompt
2. Install the app on your home screen
3. Test offline functionality from the installed app

## 🎯 What Should Work Offline

### ✅ Fully Functional Offline:
- **Navigation**: All app screens and navigation
- **UI Components**: Buttons, forms, layouts
- **Product Data**: Cached product information
- **Images**: Cached product images
- **App Logic**: All Flutter business logic
- **Animations**: Smooth transitions and effects

### ⚠️ Limited Offline:
- **Search**: May not work without server
- **User Authentication**: Login/logout features
- **Real-time Data**: Live updates and notifications
- **Payment Processing**: Checkout functionality

## 🔍 Debugging Offline Issues

### Check Service Worker:
```javascript
// In browser console
navigator.serviceWorker.getRegistrations().then(registrations => {
  console.log('Service Workers:', registrations);
});
```

### Check Cache:
```javascript
// In browser console
caches.keys().then(names => {
  console.log('Cache names:', names);
});
```

### Force Cache Update:
1. Open DevTools
2. Go to **Application** tab
3. Right-click on **Service Workers**
4. Select **"Unregister"**
5. Refresh page to re-register

## 📊 Performance Testing

### First Load (Online):
- Initial load time: ~2-5 seconds
- WASM compilation: ~1-2 seconds
- Asset loading: ~1-3 seconds

### Subsequent Loads (Offline):
- Load time: <1 second
- Instant navigation
- Smooth interactions

## 🛠️ Troubleshooting

### App Not Loading Offline:
1. Check if service worker is registered
2. Verify cache storage has content
3. Clear browser cache and reload
4. Check browser console for errors

### Slow Offline Performance:
1. Check if WASM files are cached
2. Verify CanvasKit assets are stored
3. Monitor memory usage in DevTools

### Missing Features Offline:
1. Check if feature requires server communication
2. Verify data is properly cached
3. Test with different network conditions

## 🎉 Success Indicators

Your offline testing is successful when:
- ✅ App loads completely offline
- ✅ All UI interactions work smoothly
- ✅ Navigation between screens works
- ✅ Product data displays correctly
- ✅ No console errors
- ✅ Fast response times

## 📱 Mobile Offline Testing Tips

1. **Use Airplane Mode**: Toggle airplane mode to test true offline
2. **Test Different Browsers**: Chrome, Safari, Firefox
3. **Check PWA Installation**: Install as app on home screen
4. **Test Network Switching**: Switch between WiFi and mobile data
5. **Monitor Battery Usage**: Offline apps should be battery efficient

## 🚀 Ready for Production

Once offline testing is successful:
1. Deploy to your chosen platform
2. Test on production URL
3. Monitor real user offline usage
4. Optimize based on usage patterns

Your WASM Flutter app is now ready for offline-first deployment! 🎉 