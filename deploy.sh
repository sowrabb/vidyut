#!/bin/bash

# Vidyut WASM Deployment Script

echo "Vidyut WebAssembly Deployment"
echo "============================="

# Check if build exists
if [ ! -d "build/web" ]; then
    echo "Error: Build directory not found. Please run ./build_wasm.sh first."
    exit 1
fi

echo "Choose deployment option:"
echo "1. Local testing"
echo "2. Netlify (drag and drop)"
echo "3. Vercel"
echo "4. GitHub Pages"
echo "5. AWS S3"
echo "6. Custom server"

read -p "Enter your choice (1-6): " choice

case $choice in
    1)
        echo "Starting local server..."
        cd build/web
        python3 -m http.server 8000
        echo "App is running at http://localhost:8000"
        ;;
    2)
        echo "Netlify deployment:"
        echo "1. Go to https://app.netlify.com/"
        echo "2. Drag and drop the 'build/web' folder"
        echo "3. Your app will be deployed automatically"
        ;;
    3)
        echo "Vercel deployment:"
        echo "1. Install Vercel CLI: npm i -g vercel"
        echo "2. Run: vercel --prod"
        echo "3. Set build output directory to 'build/web'"
        ;;
    4)
        echo "GitHub Pages deployment:"
        echo "1. Create a new branch: git checkout -b gh-pages"
        echo "2. Copy build/web contents to root"
        echo "3. Commit and push: git push origin gh-pages"
        echo "4. Enable GitHub Pages in repository settings"
        ;;
    5)
        echo "AWS S3 deployment:"
        echo "1. Create an S3 bucket"
        echo "2. Enable static website hosting"
        echo "3. Upload build/web contents to bucket"
        echo "4. Configure bucket policy for public access"
        ;;
    6)
        echo "Custom server deployment:"
        echo "Upload the contents of 'build/web' to your web server"
        echo "Ensure your server supports static file hosting"
        ;;
    *)
        echo "Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "Deployment instructions completed!" 