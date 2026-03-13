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

namespace FuseCP.Providers.Statistics
{
    /// <summary>
    /// Abstraction layer for SmarterStats automation transport.
    /// </summary>
    public interface ISmarterStatsAutomationClient
    {
        ServerInfoArrayResult GetServers(string username, string password);
        SiteInfoArrayResult GetAllSites(string username, string password, bool includeSystemSites);
        SiteInfoResult GetSite(string username, string password, int siteId);

        GenericResult1 AddSite(
            string username,
            string password,
            string siteAdminUser,
            string siteAdminPassword,
            string siteAdminFirstName,
            string siteAdminLastName,
            int serverId,
            int siteId,
            string domainName,
            string logDirectory,
            string logFormat,
            string logWildcard,
            int logDaysBeforeDelete,
            string smarterLogDirectory,
            int smarterLogMonthsBeforeDelete,
            string exportPath,
            string exportPathUrl,
            int timeZoneId);

        GenericResult1 UpdateSite(
            string username,
            string password,
            int siteId,
            string domainName,
            string logDirectory,
            string logFormat,
            string logWildcard,
            int logDaysBeforeDelete,
            string smarterLogDirectory,
            int smarterLogMonthsBeforeDelete,
            string exportPath,
            string exportPathUrl,
            int timeZoneId);

        GenericResult1 DeleteSite(string username, string password, int siteId, bool deleteReports);

        UserInfoResultArray GetUsers(string username, string password, int siteId);
        GenericResult2 AddUser(string username, string password, int siteId, string userName, string userPassword, string firstName, string lastName, bool isAdmin);
        GenericResult2 UpdateUser(string username, string password, int siteId, string userName, string userPassword, string firstName, string lastName, bool isAdmin);
        GenericResult2 DeleteUser(string username, string password, int siteId, string userName);
    }
}