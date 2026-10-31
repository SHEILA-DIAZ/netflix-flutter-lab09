"""Genera labxy.zip con los archivos reproducibles del laboratorio."""
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED

root = Path(__file__).resolve().parent.parent
folders = ['lib', 'test', 'assets', 'android', 'web', 'scripts', '.vscode']
root_files = ['pubspec.yaml', 'pubspec.lock', 'analysis_options.yaml', 'README.md', '.gitignore', '.metadata']
excluded_dirs = {'build', 'ephemeral', '.gradle', '.dart_tool', '.symlinks', 'Pods', 'xcuserdata', '.plugin_symlinks', '__pycache__'}
excluded_files = {'local.properties', 'key.properties', '.DS_Store', '.env', '.last_build_id'}
selected = [root / name for name in root_files if (root / name).is_file()]
for folder in folders:
    for path in (root / folder).rglob('*'):
        relative = path.relative_to(root)
        if (path.is_file() and not any(part in excluded_dirs for part in relative.parts)
            and path.name not in excluded_files and path.suffix not in {'.jks', '.keystore', '.user'}):
            selected.append(path)
with ZipFile(root / 'labxy.zip', 'w', compression=ZIP_DEFLATED) as archive:
    for path in sorted(selected):
        archive.write(path, 'streamhub/' + path.relative_to(root).as_posix())
print('labxy.zip creado con', len(selected), 'archivos.')

