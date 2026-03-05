<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SmarterMail_EditDomain_Sharing.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.SmaterMail_EditDomain_Sharing" %>
<table width="100%">
    <tr>
        <td class="text-end" style="width:150px;"><asp:Label runat="server" meta:resourcekey="cbGlobalAddressList"/></td>
        <td><asp:CheckBox runat="server" ID="cbGlobalAddressList"  /></td>        
    </tr>
    <tr>
        <td class="text-end"><asp:Label ID="Label1" runat="server" meta:resourcekey="cbSharedCalendars" /></td>
        <td><asp:CheckBox runat="server" ID="cbSharedCalendars" /></td>
    </tr>
    <tr>
        <td class="text-end"><asp:Label ID="Label2" runat="server" meta:resourcekey="cbSharedContacts" /></td>
        <td><asp:CheckBox runat="server" ID="cbSharedContacts" /></td>        
    </tr>
    <tr>
        <td class="text-end"><asp:Label ID="Label3" runat="server" meta:resourcekey="cbSharedFolders"/></td>
        <td><asp:CheckBox runat="server" ID="cbSharedFolders" /></td>
    </tr>
    <tr>
        <td class="text-end"><asp:Label ID="Label4" runat="server" meta:resourcekey="cbSharedNotes" /></td>
        <td><asp:CheckBox runat="server" ID="cbSharedNotes"  /></td>        
    </tr>
    <tr>
        <td class="text-end"><asp:Label ID="Label5" runat="server" meta:resourcekey="cbSharedTasks" /></td>
        <td><asp:CheckBox runat="server" ID="cbSharedTasks"  /></td>
    </tr>
</table>
