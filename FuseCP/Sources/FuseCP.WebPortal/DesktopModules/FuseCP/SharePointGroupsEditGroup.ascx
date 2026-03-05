<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SharePointGroupsEditGroup.ascx.cs" Inherits="FuseCP.Portal.SharePointGroupsEditGroup" %>
<%@ Register Src="UserControls/UsernameControl.ascx" TagName="UsernameControl" TagPrefix="uc2" %>
<%@ Register TagPrefix="fcp" TagName="CollapsiblePanel" Src="UserControls/CollapsiblePanel.ascx" %>
<div class="card-body form-horizontal">
    <table cellSpacing="0" cellPadding="5" width="100%">
        <tr>
            <td class="SubHead" noWrap width="200"><asp:Label ID="lblGroupName" runat="server" meta:resourcekey="lblGroupName" Text="Group name:"></asp:Label></td>
            <td class="NormalBold" width="100%">
                <uc2:UsernameControl ID="usernameControl" runat="server" />
            </td>
        </tr>
    </table>
    
    <fcp:CollapsiblePanel id="secUsers" runat="server"
        TargetControlID="UsersPanel" meta:resourcekey="secUsers" Text="Members">
    </fcp:CollapsiblePanel>
    <asp:Panel ID="UsersPanel" runat="server" Height="0" style="overflow:hidden;">
        <table id="tblUsers" runat="server" cellSpacing="0" cellPadding="3" width="100%">
            <tr>
                <td colspan="2">
	                <asp:checkboxlist id="dlUsers" CellPadding="3" RepeatColumns="2" CssClass="NormalBold" Runat="server"
		                DataValueField="Name" DataTextField="Name"></asp:checkboxlist>
                </td>
            </tr>
        </table>
    </asp:Panel>
</div>
<div class="card-footer text-end">
    <asp:LinkButton id="btnDelete" CssClass="btn btn-danger" runat="server" CausesValidation="False" OnClick="btnDelete_Click" OnClientClick="return confirm('Delete this user?');"> <i class="bi bi-trash">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnDeleteText"/> </asp:LinkButton>&nbsp;
    <asp:LinkButton id="btnCancel" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnCancel_Click"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancel"/> </asp:LinkButton>&nbsp;
	<asp:LinkButton id="btnSave" CssClass="btn btn-success" runat="server" OnClick="btnSave_Click"> <i class="bi bi-floppy">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnSave"/> </asp:LinkButton>
</div>
