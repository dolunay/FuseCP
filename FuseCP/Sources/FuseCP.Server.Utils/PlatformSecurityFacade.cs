// Copyright (C) 2026 FuseCP
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

using System;
using System.Runtime.Versioning;

namespace FuseCP.Providers.Utils
{
    /// <summary>
    /// Cross-platform facade for security operations that are only meaningful on Windows.
    /// </summary>
    public static class PlatformSecurityFacade
    {
        public static void TryApplyDefaultPackageFolderPermissions(string path)
        {
            if (!OperatingSystem.IsWindows())
                return;

            ApplyDefaultPackageFolderPermissionsWindows(path);
        }

        public static void TryResetInheritedFilePermissions(string path)
        {
            if (!OperatingSystem.IsWindows())
                return;

            ResetInheritedFilePermissionsWindows(path);
        }

        [SupportedOSPlatform("windows")]
        private static void ApplyDefaultPackageFolderPermissionsWindows(string path)
        {
            SecurityUtils.GrantNtfsPermissionsBySid(path, SystemSID.ADMINISTRATORS, NTFSPermission.FullControl, true, true);
            SecurityUtils.GrantNtfsPermissionsBySid(path, SystemSID.SYSTEM, NTFSPermission.FullControl, true, true);
        }

        [SupportedOSPlatform("windows")]
        private static void ResetInheritedFilePermissionsWindows(string path)
        {
            SecurityUtils.ResetNtfsPermissions(path);
        }
    }
}
