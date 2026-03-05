using System;
using System.Collections.Generic;
using System.Reflection;
using System.Collections.Specialized;

namespace FuseCP.EnterpriseServer
{
    public class Service
    {
        public int SpaceId { get; set; }
        public int ServiceId { get; set; }
        public int UserId { get; set; }
    }

    public class ServiceUser
    {
        public int UserId { get; set; }
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
        public UserRole Role { get; set; }
        public UserStatus Status { get; set; }
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

    public class ServiceLifeCycle
    {
        public int CycleLength { get; set; }
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

    public class CheckoutDetails : Dictionary<string, string>
    {
        public string[] GetAllKeys()
        {
            string[] keys = new string[Keys.Count];
            Keys.CopyTo(keys, 0);
            return keys;
        }
    }

    public class TransactionResult : Dictionary<string, string>
    {
        public bool Succeed
        {
            get { return TryGetValue(nameof(Succeed), out string value) && bool.TryParse(value, out bool parsed) && parsed; }
            set { this[nameof(Succeed)] = value.ToString(); }
        }

        public string TransactionId
        {
            get { return TryGetValue(nameof(TransactionId), out string value) ? value : string.Empty; }
            set { this[nameof(TransactionId)] = value ?? string.Empty; }
        }

        public TransactionStatus TransactionStatus
        {
            get
            {
                if (TryGetValue(nameof(TransactionStatus), out string value) && Enum.TryParse(value, out TransactionStatus parsed))
                    return parsed;
                return TransactionStatus.Declined;
            }
            set { this[nameof(TransactionStatus)] = value.ToString(); }
        }

        public string RawResponse
        {
            get { return TryGetValue(nameof(RawResponse), out string value) ? value : string.Empty; }
            set { this[nameof(RawResponse)] = value ?? string.Empty; }
        }

        public string StatusCode
        {
            get { return TryGetValue(nameof(StatusCode), out string value) ? value : string.Empty; }
            set { this[nameof(StatusCode)] = value ?? string.Empty; }
        }
    }
    public class FormParameters : Dictionary<string, string>
    {
        public const string CONTRACT = nameof(CONTRACT);
        public const string INVOICE = nameof(INVOICE);
        public const string CURRENCY = nameof(CURRENCY);
        public const string AMOUNT = nameof(AMOUNT);
        public const string FIRST_NAME = nameof(FIRST_NAME);
        public const string LAST_NAME = nameof(LAST_NAME);
        public const string ADDRESS = nameof(ADDRESS);
        public const string CITY = nameof(CITY);
        public const string STATE = nameof(STATE);
        public const string COUNTRY = nameof(COUNTRY);
        public const string ZIP = nameof(ZIP);
        public const string EMAIL = nameof(EMAIL);
        public const string PHONE = nameof(PHONE);
    }

    public class CheckoutFormParams : FormParameters
    {
        public const string POST_METHOD = "POST";

        public string Action { get; set; }
        public string Method { get; set; }
    }

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

        public string[] GetAllKeys()
        {
            string[] keys = new string[Keys.Count];
            Keys.CopyTo(keys, 0);
            return keys;
        }
    }

    public enum TransactionStatus
    {
        Approved = 0,
        Pending = 1,
        Declined = 2
    }

    public class CheckoutKeys
    {
        public const string Address = nameof(Address);
        public const string Amount = nameof(Amount);
        public const string CardNumber = nameof(CardNumber);
        public const string CardType = nameof(CardType);
        public const string City = nameof(City);
        public const string ContractNumber = nameof(ContractNumber);
        public const string Country = nameof(Country);
        public const string Currency = nameof(Currency);
        public const string CustomerEmail = nameof(CustomerEmail);
        public const string CustomerId = nameof(CustomerId);
        public const string ExpireMonth = nameof(ExpireMonth);
        public const string ExpireYear = nameof(ExpireYear);
        public const string Fax = nameof(Fax);
        public const string FirstName = nameof(FirstName);
        public const string InvoiceNumber = nameof(InvoiceNumber);
        public const string IPAddress = nameof(IPAddress);
        public const string IssueNumber = nameof(IssueNumber);
        public const string LastName = nameof(LastName);
        public const string Phone = nameof(Phone);
        public const string ShipToAddress = nameof(ShipToAddress);
        public const string ShipToCity = nameof(ShipToCity);
        public const string ShipToCompany = nameof(ShipToCompany);
        public const string ShipToCountry = nameof(ShipToCountry);
        public const string ShipToFirstName = nameof(ShipToFirstName);
        public const string ShipToLastName = nameof(ShipToLastName);
        public const string ShipToState = nameof(ShipToState);
        public const string ShipToZip = nameof(ShipToZip);
        public const string StartMonth = nameof(StartMonth);
        public const string StartYear = nameof(StartYear);
        public const string State = nameof(State);
        public const string VerificationCode = nameof(VerificationCode);
        public const string Zip = nameof(Zip);
    }

    public class RegisterDomainResult : Dictionary<string, string>
    {
        public const string ORDER_NUMBER = nameof(ORDER_NUMBER);
    }

    public class RenewDomainResult : Dictionary<string, string>
    {
        public const string RENEW_ORDER_NUMBER = nameof(RENEW_ORDER_NUMBER);
        public const string REGISTRAR = nameof(REGISTRAR);
    }

    public class AccountResult : Dictionary<string, string>
    {
        public const string ACCOUNT_LOGIN_ID = nameof(ACCOUNT_LOGIN_ID);
        public const string ACCOUNT_ID = nameof(ACCOUNT_ID);
        public const string ACCOUNT_PARTY_ID = nameof(ACCOUNT_PARTY_ID);

        public string[] AllKeys
        {
            get
            {
                string[] keys = new string[Keys.Count];
                Keys.CopyTo(keys, 0);
                return keys;
            }
        }
    }

    public enum DomainStatus
    {
        NotFound = 0,
        Registered = 1
    }

    public class DomainNameSvc : Dictionary<string, string>
    {
        public string Fqdn { get; set; }
        public int PeriodLength { get; set; }
    }

    public class ContractAccount : Dictionary<string, string>
    {
        public const string EMAIL = nameof(EMAIL);
        public const string PASSWORD = nameof(PASSWORD);
        public const string FIRST_NAME = nameof(FIRST_NAME);
        public const string LAST_NAME = nameof(LAST_NAME);
        public const string COMPANY_NAME = nameof(COMPANY_NAME);
        public const string ADDRESS = nameof(ADDRESS);
        public const string CITY = nameof(CITY);
        public const string STATE = nameof(STATE);
        public const string COUNTRY = nameof(COUNTRY);
        public const string ZIP = nameof(ZIP);
        public const string PHONE_NUMBER = nameof(PHONE_NUMBER);
        public const string FAX_NUMBER = nameof(FAX_NUMBER);
    }

    public class DomainContact : Dictionary<string, string>
    {
        public bool HasKey(string key)
        {
            return ContainsKey(key);
        }
    }

    public class DomainContacts : Dictionary<string, DomainContact> { }

    public class TransferDomainResult : Dictionary<string, string>
    {
        public const string TRANSFER_ORDER_NUMBER = nameof(TRANSFER_ORDER_NUMBER);
    }

    internal static class LegacyControllerBridge
    {
        internal static object CreateController(string controllerTypeName)
        {
            Assembly codeAssembly = null;
            try { codeAssembly = Assembly.Load("FuseCP.EnterpriseServer.Code"); }
            catch { /* keep null */ }

            if (codeAssembly == null)
            {
                foreach (Assembly loaded in AppDomain.CurrentDomain.GetAssemblies())
                {
                    if (string.Equals(loaded.GetName().Name, "FuseCP.EnterpriseServer.Code", StringComparison.OrdinalIgnoreCase))
                    {
                        codeAssembly = loaded;
                        break;
                    }
                }
            }

            if (codeAssembly == null)
                throw new InvalidOperationException("FuseCP.EnterpriseServer.Code assembly is not available.");

            Type controllerBaseType = codeAssembly.GetType("FuseCP.EnterpriseServer.ControllerBase", throwOnError: true);
            Type controllerType = codeAssembly.GetType(controllerTypeName, throwOnError: true);

            object root = Activator.CreateInstance(controllerBaseType);
            return Activator.CreateInstance(controllerType, new[] { root });
        }

        internal static object Invoke(object target, string methodName, params object[] args)
        {
            Type[] argTypes = new Type[args.Length];
            for (int i = 0; i < args.Length; i++)
                argTypes[i] = args[i]?.GetType() ?? typeof(object);

            MethodInfo method = target.GetType().GetMethod(methodName, argTypes);
            if (method == null)
            {
                foreach (MethodInfo candidate in target.GetType().GetMethods())
                {
                    if (!string.Equals(candidate.Name, methodName, StringComparison.Ordinal))
                        continue;

                    ParameterInfo[] parameters = candidate.GetParameters();
                    if (parameters.Length != args.Length)
                        continue;

                    method = candidate;
                    break;
                }
            }

            if (method == null)
                throw new MissingMethodException(target.GetType().FullName, methodName);

            return method.Invoke(target, args);
        }
    }

    public static class Utils
    {
        public static int ParseInt(string val, int defaultValue)
        {
            int parsed;
            return int.TryParse(val, out parsed) ? parsed : defaultValue;
        }
    }

    public static class PackageController
    {
        public static FuseCP.EnterpriseServer.PackageAddonInfo GetPackageAddon(int packageAddonId)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.PackageController");
            return (FuseCP.EnterpriseServer.PackageAddonInfo)LegacyControllerBridge.Invoke(controller, "GetPackageAddon", packageAddonId);
        }

        public static FuseCP.EnterpriseServer.PackageResult UpdatePackageAddon(FuseCP.EnterpriseServer.PackageAddonInfo addon)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.PackageController");
            return (FuseCP.EnterpriseServer.PackageResult)LegacyControllerBridge.Invoke(controller, "UpdatePackageAddon", addon);
        }

        public static FuseCP.EnterpriseServer.PackageResult AddPackageAddon(FuseCP.EnterpriseServer.PackageAddonInfo addon)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.PackageController");
            return (FuseCP.EnterpriseServer.PackageResult)LegacyControllerBridge.Invoke(controller, "AddPackageAddon", addon);
        }

        public static int ChangePackageStatus(int packageId, FuseCP.EnterpriseServer.PackageStatus status, bool async)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.PackageController");
            return (int)LegacyControllerBridge.Invoke(controller, "ChangePackageStatus", packageId, status, async);
        }

        public static FuseCP.EnterpriseServer.PackageResult AddPackage(int userId, int planId, string packageName, string packageComments, int statusId, DateTime purchaseDate, bool calculateDiskSpace)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.PackageController");
            return (FuseCP.EnterpriseServer.PackageResult)LegacyControllerBridge.Invoke(controller, "AddPackage", userId, planId, packageName, packageComments, statusId, purchaseDate, calculateDiskSpace);
        }

        public static int DeletePackage(int packageId)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.PackageController");
            return (int)LegacyControllerBridge.Invoke(controller, "DeletePackage", packageId);
        }

        public static FuseCP.EnterpriseServer.PackageInfo GetPackage(int packageId)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.PackageController");
            return (FuseCP.EnterpriseServer.PackageInfo)LegacyControllerBridge.Invoke(controller, "GetPackage", packageId);
        }

        public static FuseCP.EnterpriseServer.PackageResult UpdatePackage(FuseCP.EnterpriseServer.PackageInfo package)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.PackageController");
            return (FuseCP.EnterpriseServer.PackageResult)LegacyControllerBridge.Invoke(controller, "UpdatePackage", package);
        }

        public static FuseCP.EnterpriseServer.PackageSettings GetPackageSettings(int packageId, string settingsName)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.PackageController");
            return (FuseCP.EnterpriseServer.PackageSettings)LegacyControllerBridge.Invoke(controller, "GetPackageSettings", packageId, settingsName);
        }
    }

    public static class ServiceController
    {
        public static FuseCP.EnterpriseServer.KeyValueBunch GetServiceSettings(int spaceId, int serviceId)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.ServerController");
            StringDictionary settings = (StringDictionary)LegacyControllerBridge.Invoke(controller, "GetServiceSettings", serviceId);
            FuseCP.EnterpriseServer.KeyValueBunch bunch = new FuseCP.EnterpriseServer.KeyValueBunch();

            if (settings != null)
            {
                foreach (string key in settings.Keys)
                    bunch[key] = settings[key];
            }

            return bunch;
        }

        public static ServiceLifeCycle GetServiceLifeCycle(int spaceId, int serviceId)
        {
            FuseCP.EnterpriseServer.KeyValueBunch settings = GetServiceSettings(spaceId, serviceId);

            int cycleLength = 1;
            if (settings != null)
            {
                cycleLength = Utils.ParseInt(settings["CycleLength"], cycleLength);
                if (cycleLength <= 0)
                    cycleLength = Utils.ParseInt(settings["Cycle"], 1);
                if (cycleLength <= 0)
                    cycleLength = Utils.ParseInt(settings["Years"], 1);
            }

            if (cycleLength <= 0)
                cycleLength = 1;

            return new ServiceLifeCycle { CycleLength = cycleLength };
        }

        public static DateTime GetServiceSuspendDate(int spaceId, int serviceId)
        {
            return DateTime.UtcNow;
        }

        public static void SetServiceLifeCycleRecord(int spaceId, int serviceId, DateTime startDate, DateTime endDate)
        {
            // Legacy API removed in modern EnterpriseServer code path.
        }
    }

    public static class UserController
    {
        public static int UpdateUser(FuseCP.EnterpriseServer.ServiceUser user)
        {
            FuseCP.EnterpriseServer.UserInfo target = new FuseCP.EnterpriseServer.UserInfo
            {
                UserId = user.UserId,
                Username = user.Username,
                FirstName = user.FirstName,
                LastName = user.LastName,
                Email = user.Email,
                Address = user.Address,
                City = user.City,
                State = user.State,
                Country = user.Country,
                Zip = user.Zip,
                Role = user.Role,
                Status = user.Status
            };

            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.UserController");
            return (int)LegacyControllerBridge.Invoke(controller, "UpdateUser", target);
        }

        public static FuseCP.EnterpriseServer.UserSettings GetUserSettings(int userId, string settingsName)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.UserController");
            return (FuseCP.EnterpriseServer.UserSettings)LegacyControllerBridge.Invoke(controller, "GetUserSettings", userId, settingsName);
        }

        public static int UpdateUserSettings(FuseCP.EnterpriseServer.UserSettings settings)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.UserController");
            return (int)LegacyControllerBridge.Invoke(controller, "UpdateUserSettings", settings);
        }
    }

    public static class ServerController
    {
        public static FuseCP.EnterpriseServer.DomainInfo GetDomain(string domainName)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.ServerController");
            return (FuseCP.EnterpriseServer.DomainInfo)LegacyControllerBridge.Invoke(controller, "GetDomain", domainName);
        }

        public static int AddDomain(FuseCP.EnterpriseServer.DomainInfo domain)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.ServerController");
            return (int)LegacyControllerBridge.Invoke(controller, "AddDomain", domain);
        }

        public static int DeleteDomain(int domainId)
        {
            object controller = LegacyControllerBridge.CreateController("FuseCP.EnterpriseServer.ServerController");
            return (int)LegacyControllerBridge.Invoke(controller, "DeleteDomain", domainId);
        }
    }

    public static class RegistrarController
    {
        public static string GetDomainTLD(string domainOrTld)
        {
            if (string.IsNullOrWhiteSpace(domainOrTld))
                return string.Empty;

            string value = domainOrTld.Trim().Trim('.');
            int idx = value.LastIndexOf('.');
            return idx >= 0 && idx + 1 < value.Length ? value.Substring(idx + 1) : value;
        }

        public static IDomainRegistrar GetTLDDomainRegistrar(int spaceId, string tld)
        {
            return new OfflineRegistrarBridge();
        }
    }

    internal sealed class OfflineRegistrarBridge : IDomainRegistrar
    {
        public string RegistrarName => "OfflineRegistrar";

        public bool CheckSubAccountExists(string account, string emailAddress)
        {
            return true;
        }

        public AccountResult GetSubAccount(string account, string emailAddress)
        {
            AccountResult result = new AccountResult();
            result[AccountResult.ACCOUNT_LOGIN_ID] = account ?? string.Empty;
            result[AccountResult.ACCOUNT_ID] = account ?? string.Empty;
            result[AccountResult.ACCOUNT_PARTY_ID] = account ?? string.Empty;
            return result;
        }

        public AccountResult CreateSubAccount(CommandParams args)
        {
            string account = args.ContainsKey(CommandParams.USERNAME) ? args[CommandParams.USERNAME] : string.Empty;
            string email = args.ContainsKey(CommandParams.EMAIL) ? args[CommandParams.EMAIL] : string.Empty;
            return GetSubAccount(account, email);
        }

        public void RegisterDomain(DomainNameSvc domainSvc, ContractAccount accountInfo, string[] nameServers)
        {
            domainSvc["OrderID"] = Guid.NewGuid().ToString("N");
        }

        public void RenewDomain(DomainNameSvc domainSvc, ContractAccount accountInfo, string[] nameServers)
        {
            domainSvc["OrderID"] = Guid.NewGuid().ToString("N");
        }
    }

    public class ToCheckoutSettings
    {
        public const string FIXED_CART = "fixed_cart";
        public const string SECRET_WORD = "secret_word";
        public const string ACCOUNT_SID = "account_sid";
        public const string CURRENCY = "2co_currency";
        public const string LIVE_MODE = "live_mode";
        public const string INTERACTIVE = "interactive";
        public const string CONTINUE_SHOPPING_URL = "continue_shopping_url";
    }

    public class AuthNetSettings
    {
        public const string MD5_HASH = "md5_hash";
        public const string TRANSACTION_KEY = "trans_key";
        public const string DEMO_ACCOUNT = "demo_account";
        public const string SEND_CONFIRMATION = "send_confirm";
        public const string MERCHANT_EMAIL = "merchant_email";
        public const string INTERACTIVE = "interactive";
        public const string LIVE_MODE = "live_mode";
        public const string USERNAME = "username";
    }

    public class OffPaymentSettings
    {
        public const string AUTO_APPROVE = "auto_approve";
        public const string TRANSACTION_NUMBER_FORMAT = "transaction_number_format";
    }

    public class PayPalStdSettings
    {
        public const string BUSINESS = "business";
        public const string RETURN_URL = "return_url";
        public const string CANCEL_RETURN_URL = "cancel_return_url";
        public const string LIVE_MODE = "live_mode";
        public const string INTERACTIVE = "interactive";
    }

    public static class LegacyRegistrarExtensions
    {
        public static bool CheckSubAccountExists(this IDomainRegistrar registrar, string account, string emailAddress)
        {
            if (registrar == null) throw new ArgumentNullException(nameof(registrar));

            MethodInfo method = registrar.GetType().GetMethod("CheckSubAccountExists", new[] { typeof(string), typeof(string) });
            if (method != null)
                return (bool)method.Invoke(registrar, new object[] { account, emailAddress });

            method = registrar.GetType().GetMethod("CheckSubAccountExists", new[] { typeof(string) });
            if (method != null)
                return (bool)method.Invoke(registrar, new object[] { emailAddress });

            return false;
        }

        public static AccountResult GetSubAccount(this IDomainRegistrar registrar, string account, string emailAddress)
        {
            if (registrar == null) throw new ArgumentNullException(nameof(registrar));

            MethodInfo method = registrar.GetType().GetMethod("GetSubAccount", new[] { typeof(string), typeof(string) });
            if (method == null)
                return new AccountResult();

            return (AccountResult)method.Invoke(registrar, new object[] { account, emailAddress });
        }

        public static AccountResult CreateSubAccount(this IDomainRegistrar registrar, CommandParams args)
        {
            if (registrar == null) throw new ArgumentNullException(nameof(registrar));

            MethodInfo method = registrar.GetType().GetMethod("CreateSubAccount", new[] { typeof(CommandParams) });
            if (method == null)
                return new AccountResult();

            return (AccountResult)method.Invoke(registrar, new object[] { args });
        }

        public static RegisterDomainResult RegisterDomain(this IDomainRegistrar registrar, CommandParams args)
        {
            if (registrar == null) throw new ArgumentNullException(nameof(registrar));
            if (args == null) throw new ArgumentNullException(nameof(args));

            DomainNameSvc domain = BuildDomainService(args);
            ContractAccount account = BuildAccount(args);
            string[] nameServers = ParseNameServers(args);

            MethodInfo method = registrar.GetType().GetMethod("RegisterDomain", new[] { typeof(DomainNameSvc), typeof(ContractAccount), typeof(string[]) });
            method?.Invoke(registrar, new object[] { domain, account, nameServers });

            RegisterDomainResult result = new RegisterDomainResult();
            result[RegisterDomainResult.ORDER_NUMBER] = ReadOrderNumber(domain);
            return result;
        }

        public static RenewDomainResult RenewDomain(this IDomainRegistrar registrar, CommandParams args)
        {
            if (registrar == null) throw new ArgumentNullException(nameof(registrar));
            if (args == null) throw new ArgumentNullException(nameof(args));

            DomainNameSvc domain = BuildDomainService(args);
            ContractAccount account = BuildAccount(args);
            string[] nameServers = ParseNameServers(args);

            MethodInfo method = registrar.GetType().GetMethod("RenewDomain", new[] { typeof(DomainNameSvc), typeof(ContractAccount), typeof(string[]) });
            method?.Invoke(registrar, new object[] { domain, account, nameServers });

            RenewDomainResult result = new RenewDomainResult();
            result[RenewDomainResult.RENEW_ORDER_NUMBER] = ReadOrderNumber(domain);
            result[RenewDomainResult.REGISTRAR] = registrar.RegistrarName;
            return result;
        }

        private static DomainNameSvc BuildDomainService(CommandParams args)
        {
            string domainName = args.ContainsKey(CommandParams.DOMAIN_NAME) ? args[CommandParams.DOMAIN_NAME] : string.Empty;
            string domainTld = args.ContainsKey(CommandParams.DOMAIN_TLD) ? args[CommandParams.DOMAIN_TLD] : string.Empty;
            string fqdn = string.IsNullOrEmpty(domainTld) ? domainName : string.Concat(domainName, ".", domainTld);

            int years = 1;
            if (args.ContainsKey(CommandParams.YEARS))
                int.TryParse(args[CommandParams.YEARS], out years);

            DomainNameSvc domain = new DomainNameSvc
            {
                Fqdn = fqdn,
                PeriodLength = years <= 0 ? 1 : years
            };

            CopyIfExists(args, domain, "NexusCategory");
            CopyIfExists(args, domain, "ApplicationPurpose");
            CopyIfExists(args, domain, "RegisteredFor");
            CopyIfExists(args, domain, "UK_LegalType");
            CopyIfExists(args, domain, "UK_CompanyIdNumber");
            CopyIfExists(args, domain, "HideWhoisInfo");
            CopyIfExists(args, domain, "EU_WhoisPolicy");
            CopyIfExists(args, domain, "EU_AgreeDelete");
            CopyIfExists(args, domain, "EU_ADRLang");
            return domain;
        }

        private static ContractAccount BuildAccount(CommandParams args)
        {
            ContractAccount account = new ContractAccount();
            account[ContractAccount.EMAIL] = args.ContainsKey(CommandParams.EMAIL) ? args[CommandParams.EMAIL] : string.Empty;
            account[ContractAccount.PASSWORD] = args.ContainsKey(CommandParams.PASSWORD) ? args[CommandParams.PASSWORD] : string.Empty;
            account[ContractAccount.FIRST_NAME] = args.ContainsKey(CommandParams.FIRST_NAME) ? args[CommandParams.FIRST_NAME] : string.Empty;
            account[ContractAccount.LAST_NAME] = args.ContainsKey(CommandParams.LAST_NAME) ? args[CommandParams.LAST_NAME] : string.Empty;
            account[ContractAccount.ADDRESS] = args.ContainsKey(CommandParams.ADDRESS) ? args[CommandParams.ADDRESS] : string.Empty;
            account[ContractAccount.CITY] = args.ContainsKey(CommandParams.CITY) ? args[CommandParams.CITY] : string.Empty;
            account[ContractAccount.STATE] = args.ContainsKey(CommandParams.STATE) ? args[CommandParams.STATE] : string.Empty;
            account[ContractAccount.COUNTRY] = args.ContainsKey(CommandParams.COUNTRY) ? args[CommandParams.COUNTRY] : string.Empty;
            account[ContractAccount.ZIP] = args.ContainsKey(CommandParams.ZIP) ? args[CommandParams.ZIP] : string.Empty;
            account[ContractAccount.PHONE_NUMBER] = args.ContainsKey(CommandParams.PHONE) ? args[CommandParams.PHONE] : string.Empty;
            account[ContractAccount.FAX_NUMBER] = args.ContainsKey(CommandParams.FAX) ? args[CommandParams.FAX] : string.Empty;
            account[ContractAccount.COMPANY_NAME] = string.Empty;
            return account;
        }

        private static string[] ParseNameServers(CommandParams args)
        {
            if (!args.ContainsKey(CommandParams.NAME_SERVERS) || string.IsNullOrWhiteSpace(args[CommandParams.NAME_SERVERS]))
                return Array.Empty<string>();

            string[] values = args[CommandParams.NAME_SERVERS]
                .Split(new[] { ',', ';', '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries);

            for (int i = 0; i < values.Length; i++)
                values[i] = values[i].Trim();

            return values;
        }

        private static string ReadOrderNumber(DomainNameSvc domain)
        {
            if (domain.TryGetValue("OrderID", out string orderId) && !string.IsNullOrWhiteSpace(orderId))
                return orderId;
            if (domain.TryGetValue("eaqid", out string eaqid) && !string.IsNullOrWhiteSpace(eaqid))
                return eaqid;
            if (domain.TryGetValue("EAQID", out string upperEaqid) && !string.IsNullOrWhiteSpace(upperEaqid))
                return upperEaqid;
            return string.Empty;
        }

        private static void CopyIfExists(CommandParams source, DomainNameSvc target, string key)
        {
            if (source.ContainsKey(key))
                target[key] = source[key];
        }
    }
}
