const fs = require('fs');
const path = require('path');

function replaceIdInJsonFiles(dir) {
  fs.readdirSync(dir).forEach(file => {
    const filePath = path.join(dir, file);
    if (fs.lstatSync(filePath).isDirectory()) {
      replaceIdInJsonFiles(filePath); // Appel récursif pour les sous-dossiers
    } else if (file.endsWith('.json')) {
      let content = fs.readFileSync(filePath, 'utf8');
      content = content.replace(/"id"/g, '"$id"'); // Remplace "id" par "$id"
      fs.writeFileSync(filePath, content, 'utf8');
    }
  });
}

// Remplacez 'path/to/your/project' par le chemin de votre projet
replaceIdInJsonFiles('C:/Users/cheikhamed.ouattara/Music/sigidaKanw');

