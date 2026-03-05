<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DomainExpirationView.ascx.cs" Inherits="FuseCP.Portal.ScheduleTaskControls.DomainExpirationView" %>


<table class="table table-borderless align-middle mb-0 w-100">
    <tr>
        <td class="SubHead text-nowrap">
            <asp:Label ID="lblEnableNotify" runat="server" meta:resourcekey="lblEnableNotify" Text="Enable Client Notification:"></asp:Label>
        </td>
        <td>
            <asp:CheckBox runat="server" ID="cbEnableNotify" /><br/>
        </td>
    </tr>
    <tr>
        <td class="SubHead text-nowrap">
            <asp:Label ID="lblSendNonExistentDomains" runat="server" meta:resourcekey="cbIncludeNonExistentDomains" Text="Include Non-Existent Domains:"></asp:Label>
        </td>
        <td>
            <asp:CheckBox runat="server" ID="cbIncludeNonExistentDomains" meta:resourcekey="cbIncludeNonExistentDomains" /><br/>
        </td>
    </tr>
    <tr>
        <td class="SubHead text-nowrap">
            <asp:Label ID="lblMailTo" runat="server" meta:resourcekey="lblMailTo" Text="Mail To:"></asp:Label>
        </td>
        <td class="Normal">
            <asp:TextBox ID="txtMailTo" runat="server" Width="95%" CssClass="form-control" MaxLength="1000"></asp:TextBox>
         </td>
    </tr>

    <tr>
        <td class="SubHead text-nowrap">
            <asp:Label ID="lblDayBeforeNotify" runat="server" meta:resourcekey="lblDayBeforeNotify" Text="Notify before (days):"></asp:Label>
        </td>
        <td class="Normal">
            <asp:TextBox ID="txtDaysBeforeNotify" runat="server" Width="95%" CssClass="form-control" MaxLength="1000" placeholder="Number of days before expiration date"></asp:TextBox>
        </td>
    </tr>
</table>
