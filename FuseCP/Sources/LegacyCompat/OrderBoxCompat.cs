using System;
using System.Collections;

namespace OrderBoxCoreLib
{
    public static class APIKit
    {
        public static class Properties
        {
            public static string Url { get; set; }
        }
    }

    public class Customer
    {
        private static Exception MissingSdk()
        {
            return new InvalidOperationException("Directi SDK is not available. Install OrderBoxCoreLib/OrderBoxDomainsLib to use Directi registrar operations.");
        }

        public Hashtable list(string userName, string password, string role, string language, int parentId,
            object a1, object a2, string emailAddress, object a3, object a4, object a5, object a6, object a7,
            object a8, object a9, object a10, object a11, int records, int page, object a12)
        {
            throw MissingSdk();
        }

        public int getCustomerId(string userName, string password, string role, string language, int parentId, string emailAddress)
        {
            throw MissingSdk();
        }

        public int addCustomer(string userName, string password, string role, string language,
            int parentId, string email, string accountPassword, string name, string companyName,
            string address1, string address2, string address3, string city, string state,
            string country, string zip, string phoneCc, string phone, string altPhoneCc,
            string altPhone, string faxCc, string fax, string culture)
        {
            throw MissingSdk();
        }
    }
}

namespace OrderBoxDomainsLib
{
    public static class APIKit
    {
        public static class Properties
        {
            public static string Url { get; set; }
        }
    }

    public class DomContact
    {
        private static Exception MissingSdk()
        {
            return new InvalidOperationException("Directi SDK is not available. Install OrderBoxCoreLib/OrderBoxDomainsLib to use Directi registrar operations.");
        }

        public Hashtable listNames(string userName, string password, string role, string language, int parentId, int customerId)
        {
            throw MissingSdk();
        }

        public int addDefaultContact(string userName, string password, string role, string language, int parentId, int customerId)
        {
            throw MissingSdk();
        }

        public int addContact(string userName, string password, string role, string language,
            int parentId, string name, string company, string email, string address1, string address2, string address3,
            string city, string state, string country, string zip, string phoneCc, string phone,
            string faxCc, string fax, int customerId, string contactType, Hashtable extraInfo)
        {
            throw MissingSdk();
        }
    }

    public class DomContactExt
    {
        private static Exception MissingSdk()
        {
            return new InvalidOperationException("Directi SDK is not available. Install OrderBoxCoreLib/OrderBoxDomainsLib to use Directi registrar operations.");
        }

        public Hashtable isValidRegistrantContact(string userName, string password, string role, string language,
            int parentId, int[] contactIds, string[] productKeys)
        {
            throw MissingSdk();
        }

        public bool setContactDetails(string userName, string password, string role, string language,
            int parentId, int contactId, Hashtable extHash, string extensionType)
        {
            throw MissingSdk();
        }
    }

    public class DomOrder
    {
        private static Exception MissingSdk()
        {
            return new InvalidOperationException("Directi SDK is not available. Install OrderBoxCoreLib/OrderBoxDomainsLib to use Directi registrar operations.");
        }

        public Hashtable checkAvailabilityMultiple(string userName, string password, string role, string language,
            int parentId, string[] domains, string[] tlds, bool suggestAlternatives)
        {
            throw MissingSdk();
        }

        public Hashtable validateDomainRegistrationParams(string userName, string password, string role, string language,
            int parentId, Hashtable domains, ArrayList nameServers, int registrant, int admin, int tech,
            int billing, int customerId, string invoiceOption)
        {
            throw MissingSdk();
        }

        public Hashtable addWithoutValidation(string userName, string password, string role, string language,
            int parentId, Hashtable domains, ArrayList nameServers, int registrant, int admin, int tech,
            int billing, int customerId, string invoiceOption)
        {
            throw MissingSdk();
        }

        public Hashtable getDetailsByDomain(string userName, string password, string role, string language,
            int parentId, string fqdn, ArrayList options)
        {
            throw MissingSdk();
        }

        public Hashtable renewDomain(string userName, string password, string role, string language,
            int parentId, Hashtable domains, string invoiceOption)
        {
            throw MissingSdk();
        }
    }
}
