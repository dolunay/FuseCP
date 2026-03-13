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

namespace FuseCP.Providers.Statistics
{
    /// <summary>
    /// Placeholder for modern SmarterStats automation transport.
    /// This class is intentionally scaffolded and will be implemented
    /// once the live SmarterStats service contract is finalized.
    /// </summary>
    public sealed class SmarterStatsModernAutomationClient : ISmarterStatsAutomationClient
    {
        private readonly string endpoint;

        public SmarterStatsModernAutomationClient(string endpoint)
        {
            this.endpoint = endpoint;
        }

        public ServerInfoArrayResult GetServers(string username, string password)
        {
            throw CreateNotImplementedException("GetServers");
        }

        public SiteInfoArrayResult GetAllSites(string username, string password, bool includeSystemSites)
        {
            throw CreateNotImplementedException("GetAllSites");
        }

        public SiteInfoResult GetSite(string username, string password, int siteId)
        {
            throw CreateNotImplementedException("GetSite");
        }

        public GenericResult1 AddSite(
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
            int timeZoneId)
        {
            throw CreateNotImplementedException("AddSite");
        }

        public GenericResult1 UpdateSite(
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
            int timeZoneId)
        {
            throw CreateNotImplementedException("UpdateSite");
        }

        public GenericResult1 DeleteSite(string username, string password, int siteId, bool deleteReports)
        {
            throw CreateNotImplementedException("DeleteSite");
        }

        public UserInfoResultArray GetUsers(string username, string password, int siteId)
        {
            throw CreateNotImplementedException("GetUsers");
        }

        public GenericResult2 AddUser(string username, string password, int siteId, string userName, string userPassword, string firstName, string lastName, bool isAdmin)
        {
            throw CreateNotImplementedException("AddUser");
        }

        public GenericResult2 UpdateUser(string username, string password, int siteId, string userName, string userPassword, string firstName, string lastName, bool isAdmin)
        {
            throw CreateNotImplementedException("UpdateUser");
        }

        public GenericResult2 DeleteUser(string username, string password, int siteId, string userName)
        {
            throw CreateNotImplementedException("DeleteUser");
        }

        private NotImplementedException CreateNotImplementedException(string operationName)
        {
            return new NotImplementedException(
                String.Format(
                    "SmarterStats modern automation operation '{0}' is not implemented yet. Endpoint='{1}'.",
                    operationName,
                    endpoint));
        }
    }
}