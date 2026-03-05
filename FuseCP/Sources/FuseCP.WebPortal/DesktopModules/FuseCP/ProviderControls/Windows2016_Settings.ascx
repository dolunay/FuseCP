<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Windows2016_Settings.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.Windows2016_Settings" %>
<table class="table table-borderless align-middle mb-0 w-100">
    <tr>
        <td class="SubHead text-nowrap">
            <asp:Label ID="lblSpacesFolder" runat="server" meta:resourcekey="lblSpacesFolder" Text="Hosting Spaces Folder:"></asp:Label>
        </td>
        <td>
            <asp:TextBox runat="server" ID="txtFolder" Width="300px" CssClass="form-control" MaxLength="255"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="SubHead text-nowrap"></td>
        <td>
            <table class="table table-sm">
                <tr>
                    <td>
                        <asp:CheckBox runat="server" AutoPostBack="false" ID="chkEnableHardQuota" meta:resourcekey="chkEnableHardQuota" Text="Enable Hard Quota:" /></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lblFileServiceInfo" meta:resourcekey="lblFileServiceInfo" Text="Install File Services role on the file server to enable the check box" Font-Italic="true" Visible="false"></asp:Label></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
