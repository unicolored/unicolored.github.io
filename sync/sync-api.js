require('dotenv').config(); // Load .env
const fs = require('fs');
const path = require('path');

function syncApiFiles() {
  const sourceDir = path.join(__dirname, '../_site/api');
  const destDir = process.env.ASSETS_PATH;

  try {
    if (!destDir) {
      throw new Error('ASSETS_PATH environment variable is not set');
    }

    if (!fs.existsSync(sourceDir)) {
      throw new Error(
        `Source directory ${sourceDir} does not exist. Run 'jekyll build' first.`,
      );
    }

    if (!fs.existsSync(destDir)) {
      fs.mkdirSync(destDir, { recursive: true });
      console.log(`Created destination directory ${destDir}`);
    }

    const files = fs.readdirSync(sourceDir);

    for (const file of files) {
      const sourcePath = path.join(sourceDir, file);
      const destPath = path.join(destDir, file);

      if (fs.statSync(sourcePath).isFile()) {
        fs.copyFileSync(sourcePath, destPath);
        console.log(`Copied ${file} to ${destPath}`);
      }
    }

    console.log(
      `Successfully synced all files from ${sourceDir} to ${destDir}`,
    );
  } catch (error) {
    console.error('Error syncing API files:', error.message);
    process.exit(1);
  }
}

syncApiFiles();
