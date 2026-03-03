// Copyright (C) 2025 FuseCP
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
using Microsoft.Web.PlatformInstaller;

namespace FuseCP.Server.Code
{
    internal sealed class WpiHelper
    {
        public const string DeafultLanguage = "en";

        public WpiHelper(string[] feeds)
        {
        }

        public string GetLogFileDirectory()
        {
            return string.Empty;
        }

        public void InstallProducts(
            string[] productsToInstall,
            bool installDependencies,
            string language,
            EventHandler<InstallStatusEventArgs> installStatusUpdated,
            EventHandler installComplete)
        {
            installComplete?.Invoke(this, EventArgs.Empty);
        }
    }
}
