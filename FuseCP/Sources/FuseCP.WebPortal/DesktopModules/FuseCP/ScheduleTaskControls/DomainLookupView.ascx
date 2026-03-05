<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DomainLookupView.ascx.cs" Inherits="FuseCP.Portal.ScheduleTaskControls.DomainLookupView" %>

<table class="table table-borderless align-middle mb-0 w-100">
    <tr>
        <td class="SubHead text-nowrap align-top">
			<asp:Label ID="lblServerName" runat="server" meta:resourcekey="lblServerName">Server Name: </asp:Label>
		</td>
        <td class="Normal">
            <asp:DropDownList ID="ddlServers" runat="server" CssClass="form-control" Width="150px" style="vertical-align: middle" />
        </td>
    </tr>
    <tr>
        <td class="SubHead text-nowrap">
            <asp:Label ID="lblDnsServers" runat="server" meta:resourcekey="lblDnsServers" Text="DNS Servers:"></asp:Label>
        </td>
        <td class="Normal">
            <asp:TextBox ID="txtDnsServers" runat="server" CssClass="form-control" MaxLength="1000"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="SubHead text-nowrap">
            <asp:Label ID="lblMailTo" runat="server" meta:resourcekey="lblMailTo" Text="Mail To:"></asp:Label>
        </td>
        <td class="Normal">
            <asp:TextBox ID="txtMailTo" runat="server" CssClass="form-control" MaxLength="1000"></asp:TextBox>
         </td>
    </tr>
    <tr>
        <td class="SubHead text-nowrap">
            <asp:Label ID="lblPause" runat="server" meta:resourcekey="lblPause" Text="Pause between queries (ms):"></asp:Label>
        </td>
        <td class="Normal">
            <asp:TextBox ID="txtPause" runat="server" CssClass="form-control" MaxLength="1000"></asp:TextBox>
         </td>
    </tr>
</table>
