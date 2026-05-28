#!/usr/bin/env python3
"""Read-only change detector for source-code-learning-analyzer.

By default this script only compares the current project file manifest with the
cached manifest. Use --update to write the current manifest after analysis.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


CACHE_DIR = Path(".codex/source-code-learning-analyzer")
MANIFEST_NAME = "cache_manifest.json"
CACHED_REPORT_NAME = "latest-report.md"

SKIP_DIRS = {
    ".git",
    ".hg",
    ".svn",
    "node_modules",
    "dist",
    "build",
    "target",
    ".venv",
    "venv",
    "__pycache__",
    ".next",
    ".turbo",
    "coverage",
    "vendor",
}

HIGH_IMPACT_NAMES = {
    "package.json",
    "Cargo.toml",
    "pyproject.toml",
    "requirements.txt",
    "pom.xml",
    "build.gradle",
    "CMakeLists.txt",
    "go.mod",
    "tsconfig.json",
    "tauri.conf.json",
    "Dockerfile",
    "docker-compose.yml",
    ".env.example",
}

HIGH_IMPACT_PATTERNS = (
    "vite.config.",
    "next.config.",
    "webpack.config.",
    "rollup.config.",
)

ENTRY_NAMES = {
    "main.py",
    "__main__.py",
    "main.rs",
    "lib.rs",
    "main.go",
    "main.ts",
    "main.tsx",
    "main.js",
    "main.jsx",
    "index.ts",
    "index.tsx",
    "index.js",
    "index.jsx",
    "app.ts",
    "app.tsx",
    "app.js",
    "app.jsx",
    "server.ts",
    "server.js",
}


def relpath(path: Path, root: Path) -> str:
    return path.relative_to(root).as_posix()


def should_skip(path: Path, root: Path) -> bool:
    try:
        rel = path.relative_to(root)
    except ValueError:
        return True
    parts = rel.parts
    if not parts:
        return False
    if len(parts) >= 2 and parts[0] == ".codex" and parts[1] == "source-code-learning-analyzer":
        return True
    return any(part in SKIP_DIRS for part in parts)


def file_hash(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def build_manifest(root: Path) -> dict[str, Any]:
    files: dict[str, Any] = {}
    for path in root.rglob("*"):
        if should_skip(path, root) or not path.is_file():
            continue
        stat = path.stat()
        files[relpath(path, root)] = {
            "size": stat.st_size,
            "sha256": file_hash(path),
        }
    return {
        "version": 1,
        "root": str(root),
        "updated_at": datetime.now(timezone.utc).isoformat(),
        "files": files,
    }


def load_manifest(path: Path) -> dict[str, Any] | None:
    if not path.exists():
        return None
    return json.loads(path.read_text(encoding="utf-8"))


def high_impact(path: str) -> bool:
    name = Path(path).name
    lowered = path.lower()
    if name in HIGH_IMPACT_NAMES or name in ENTRY_NAMES:
        return True
    if any(name.startswith(pattern) for pattern in HIGH_IMPACT_PATTERNS):
        return True
    return any(segment in lowered for segment in ("/routes/", "/router/", "/api/", "/models/", "/schema/"))


def compare(old: dict[str, Any] | None, new: dict[str, Any]) -> dict[str, Any]:
    if old is None:
        paths = sorted(new["files"])
        return {
            "status": "missing_cache",
            "full_required": True,
            "added": paths,
            "changed": [],
            "deleted": [],
            "high_impact_changes": sorted(p for p in paths if high_impact(p)),
        }

    old_files = old.get("files", {})
    new_files = new["files"]
    added = sorted(set(new_files) - set(old_files))
    deleted = sorted(set(old_files) - set(new_files))
    changed = sorted(
        path
        for path in set(old_files) & set(new_files)
        if old_files[path].get("sha256") != new_files[path].get("sha256")
    )
    touched = added + changed + deleted
    high = sorted(p for p in touched if high_impact(p))
    return {
        "status": "clean" if not touched else "changed",
        "full_required": False,
        "added": added,
        "changed": changed,
        "deleted": deleted,
        "high_impact_changes": high,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description="Compare project files with source-code-learning-analyzer cache.")
    parser.add_argument("root", nargs="?", default=".", help="Project root to inspect.")
    parser.add_argument("--update", action="store_true", help="Write the current manifest to the analyzer cache.")
    parser.add_argument("--report-path", help="Remember the latest user-visible Markdown report path.")
    args = parser.parse_args()

    root = Path(args.root).resolve()
    cache_dir = root / CACHE_DIR
    manifest_path = cache_dir / MANIFEST_NAME
    cached_report_path = cache_dir / CACHED_REPORT_NAME

    old = load_manifest(manifest_path)
    new = build_manifest(root)
    result = compare(old, new)

    old_report_path = old.get("report_path") if old else None
    report_path = args.report_path or old_report_path
    if report_path:
        report = Path(report_path)
        if not report.is_absolute():
            report_path = str((root / report).resolve())
    new["report_path"] = report_path
    new["cached_report_path"] = str(cached_report_path)

    result.update(
        {
            "cache_path": str(manifest_path),
            "cached_report_path": str(cached_report_path),
            "cached_report_exists": cached_report_path.exists(),
            "report_path": report_path,
            "report_exists": bool(report_path and Path(report_path).exists()),
            "file_count": len(new["files"]),
        }
    )

    if args.update:
        cache_dir.mkdir(parents=True, exist_ok=True)
        manifest_path.write_text(json.dumps(new, ensure_ascii=False, indent=2), encoding="utf-8")

    print(json.dumps(result, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
