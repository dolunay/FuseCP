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
using System.Web.Services.Protocols;

namespace FuseCP.Providers.Statistics
{
    /// <summary>
    /// Current transport implementation based on SmarterStats ASMX SOAP services.
    /// </summary>
    public sealed class SmarterStatsSoapAutomationClient : ISmarterStatsAutomationClient
    {
        private readonly string smarterUrl;

        public SmarterStatsSoapAutomationClient(string smarterUrl)
        {
            this.smarterUrl = smarterUrl;
        }

        public ServerInfoArrayResult GetServers(string username, string password)
        {
            ServerAdmin serverAdmin = CreateConfiguredProxy(new ServerAdmin());
            return serverAdmin.GetServers(username, password);
        }

        public SiteInfoArrayResult GetAllSites(string username, string password, bool includeSystemSites)
        {
            SiteAdmin siteAdmin = CreateConfiguredProxy(new SiteAdmin());
            return siteAdmin.GetAllSites(username, password, includeSystemSites);
        }

        public SiteInfoResult GetSite(string username, string password, int siteId)
        {
            SiteAdmin siteAdmin = CreateConfiguredProxy(new SiteAdmin());
            return siteAdmin.GetSite(username, password, siteId);
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
            SiteAdmin siteAdmin = CreateConfiguredProxy(new SiteAdmin());
            return siteAdmin.AddSite(
                username,
                password,
                siteAdminUser,
                siteAdminPassword,
                siteAdminFirstName,
                siteAdminLastName,
                serverId,
                siteId,
                domainName,
                logDirectory,
                logFormat,
                logWildcard,
                logDaysBeforeDelete,
                smarterLogDirectory,
                smarterLogMonthsBeforeDelete,
                exportPath,
                exportPathUrl,
                timeZoneId);
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
            SiteAdmin siteAdmin = CreateConfiguredProxy(new SiteAdmin());
            return siteAdmin.UpdateSite(
                username,
                password,
                siteId,
                domainName,
                logDirectory,
                logFormat,
                logWildcard,
                logDaysBeforeDelete,
                smarterLogDirectory,
                smarterLogMonthsBeforeDelete,
                exportPath,
                exportPathUrl,
                timeZoneId);
        }

        public GenericResult1 DeleteSite(string username, string password, int siteId, bool deleteReports)
        {
            SiteAdmin siteAdmin = CreateConfiguredProxy(new SiteAdmin());
            return siteAdmin.DeleteSite(username, password, siteId, deleteReports);
        }

        public UserInfoResultArray GetUsers(string username, string password, int siteId)
        {
            UserAdmin userAdmin = CreateConfiguredProxy(new UserAdmin());
            return userAdmin.GetUsers(username, password, siteId);
        }

        public GenericResult2 AddUser(string username, string password, int siteId, string userName, string userPassword, string firstName, string lastName, bool isAdmin)
        {
            UserAdmin userAdmin = CreateConfiguredProxy(new UserAdmin());
            return userAdmin.AddUser(username, password, siteId, userName, userPassword, firstName, lastName, isAdmin);
        }

        public GenericResult2 UpdateUser(string username, string password, int siteId, string userName, string userPassword, string firstName, string lastName, bool isAdmin)
        {
            UserAdmin userAdmin = CreateConfiguredProxy(new UserAdmin());
            return userAdmin.UpdateUser(username, password, siteId, userName, userPassword, firstName, lastName, isAdmin);
        }

        public GenericResult2 DeleteUser(string username, string password, int siteId, string userName)
        {
            UserAdmin userAdmin = CreateConfiguredProxy(new UserAdmin());
            return userAdmin.DeleteUser(username, password, siteId, userName);
        }

        private T CreateConfiguredProxy<T>(T proxy)
            where T : SoapHttpClientProtocol
        {
            if (String.IsNullOrWhiteSpace(smarterUrl))
                throw new InvalidOperationException("SmarterStats provider setting 'SmarterUrl' is missing or empty.");

            string normalizedUrl = smarterUrl;
            int idx = proxy.Url.LastIndexOf("/");

            if (normalizedUrl[normalizedUrl.Length - 1] == '/')
                normalizedUrl = normalizedUrl.Substring(0, normalizedUrl.Length - 1);

            proxy.Url = normalizedUrl + proxy.Url.Substring(idx);
            return proxy;
        }
    }
}