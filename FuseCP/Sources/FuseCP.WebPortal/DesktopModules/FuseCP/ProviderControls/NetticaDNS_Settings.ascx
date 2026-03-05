<%@ Control Language="C#" AutoEventWireup="true" Codebehind="NetticaDNS_Settings.ascx.cs"
    Inherits="FuseCP.Portal.ProviderControls.NetticaDNS_Settings" %>
<%@ Register Src="Common_IPAddressesList.ascx" TagName="IPAddressesList" TagPrefix="uc2" %>
<%@ Register Src="Common_SecondaryDNSServers.ascx" TagName="SecondaryDNSServers"
    TagPrefix="uc1" %>
<table class="table table-borderless align-middle mb-0 w-100">
    <tr>
        <td class="SubHead text-nowrap">
            <asp:Label runat="server" ID="lblUserName" meta:resourcekey="lblUserName" /></td>
        <td class="Normal">
            <asp:TextBox runat="server" ID="txtUserName" MaxLength="1000" />
            <asp:RequiredFieldValidator runat="server" ErrorMessage="*" ControlToValidate="txtUserName" Display="Dynamic" />    
        </td>
    </tr>
    <tr id="rowPassword" runat="server">
		<td class="SubHead">
		    <asp:Label ID="lblCurrPassword" runat="server" meta:resourcekey="lblCurrPassword" Text="Current User Password:"></asp:Label>
		</td>
		<td class="Normal">*******
		</td>
	</tr>
    <tr>
        <td class="SubHead text-nowrap">
            <asp:Label runat="server" ID="lblPassword" meta:resourcekey="lblPassword" /></td>
        <td class="Normal">
            <asp:TextBox runat="server" ID="txtPassword"  TextMode="Password" 
                MaxLength="1000" Width="150px" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtUserName" Display="Dynamic" />                
            </td>
    </tr>
    <tr>
            <td class="SubHead text-nowrap align-top">
			    <asp:Label ID="lblIPAddresses" runat="server" meta:resourcekey="lblIPAddresses" Text="Listening IP Addresses:"></asp:Label>
			</td>
            <td class="align-top">
                <uc2:IPAddressesList id="iPAddressesList" runat="server">
                </uc2:IPAddressesList></td>
		</tr>
    <tr>
            <td class="SubHead align-top">
		        <asp:Label ID="lblSecondaryDNS" runat="server" meta:resourcekey="lblSecondaryDNS" Text="Secondary DNS Services:"></asp:Label>
		    </td>
            <td class="Normal align-top">
                <uc1:SecondaryDNSServers ID="secondaryDNSServers" runat="server" />
            </td>
		</tr>
	<tr>
	    <td></td>
	    <td><asp:CheckBox runat="server" ID="cbApplyDefaultTemplate" meta:resourcekey="cbApplyDefaultTemplate"/></td>
	</tr>		        
</table>

