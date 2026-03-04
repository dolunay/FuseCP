using System;
using System.Collections.Generic;

namespace FuseCP.EnterpriseServer
{
    public class Service
    {
        public int SpaceId { get; set; }
    }

    public class ServiceUser
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Country { get; set; }
        public string Zip { get; set; }
        public string PrimaryPhone { get; set; }
        public string Fax { get; set; }
    }
}

namespace FuseCP.Ecommerce.EnterpriseServer
{
    public interface IProvisioningController { }
    public interface IPaymentGatewayProvider { }
    public interface IInteractivePaymentGatewayProvider : IPaymentGatewayProvider { }
    public interface IDomainRegistrar
    {
        string RegistrarName { get; }
    }

    public class SystemPluginBase
    {
        protected Dictionary<string, string> PluginSettings { get; } = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        public virtual string[] SecureSettings => Array.Empty<string>();
    }

    public class ProvisioningControllerBase
    {
        protected FuseCP.EnterpriseServer.Service ServiceInfo { get; }
        protected Dictionary<string, string> ServiceSettings { get; } = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        protected FuseCP.EnterpriseServer.ServiceUser UserInfo { get; } = new FuseCP.EnterpriseServer.ServiceUser();

        protected ProvisioningControllerBase(FuseCP.EnterpriseServer.Service serviceInfo)
        {
            ServiceInfo = serviceInfo;
        }

        public virtual void LoadProvisioningSettings() { }
    }

    public class CheckoutDetails : Dictionary<string, string> { }
    public class TransactionResult : Dictionary<string, string> { }
    public class FormParameters : Dictionary<string, string> { }

    public class CheckoutFormParams : FormParameters { }

    public class InvoiceItem
    {
        public string Description { get; set; }
        public decimal Amount { get; set; }
    }

    public class CommandParams : Dictionary<string, string>
    {
        public const string DOMAIN_NAME = nameof(DOMAIN_NAME);
        public const string DOMAIN_TLD = nameof(DOMAIN_TLD);
        public const string YEARS = nameof(YEARS);
        public const string USERNAME = nameof(USERNAME);
        public const string PASSWORD = nameof(PASSWORD);
        public const string FIRST_NAME = nameof(FIRST_NAME);
        public const string LAST_NAME = nameof(LAST_NAME);
        public const string EMAIL = nameof(EMAIL);
        public const string ADDRESS = nameof(ADDRESS);
        public const string CITY = nameof(CITY);
        public const string STATE = nameof(STATE);
        public const string COUNTRY = nameof(COUNTRY);
        public const string ZIP = nameof(ZIP);
        public const string PHONE = nameof(PHONE);
        public const string FAX = nameof(FAX);
        public const string NAME_SERVERS = nameof(NAME_SERVERS);
    }

    public class AccountResult : Dictionary<string, string>
    {
        public const string ACCOUNT_LOGIN_ID = nameof(ACCOUNT_LOGIN_ID);
        public const string ACCOUNT_ID = nameof(ACCOUNT_ID);
        public const string ACCOUNT_PARTY_ID = nameof(ACCOUNT_PARTY_ID);
    }

    public class DomainStatus : Dictionary<string, string> { }
    public class DomainNameSvc { }
    public class ContractAccount : Dictionary<string, string> { }

    public class DomainContacts : Dictionary<string, string> { }

    public class TransferDomainResult : Dictionary<string, string>
    {
        public const string TRANSFER_ORDER_NUMBER = nameof(TRANSFER_ORDER_NUMBER);
    }
}
