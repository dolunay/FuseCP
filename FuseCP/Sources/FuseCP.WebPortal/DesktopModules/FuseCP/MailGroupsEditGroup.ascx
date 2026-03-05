<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MailGroupsEditGroup.ascx.cs" Inherits="FuseCP.Portal.MailGroupsEditGroup" %>
<%@ Register TagPrefix="dnc" TagName="EmailAddress" Src="MailEditAddress.ascx" %>
<%@ Register Src="UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport"
	TagPrefix="fcp" %>
<fcp:EnableAsyncTasksSupport id="asyncTasks" runat="server" />

<script type="text/javascript">

function confirmation() 
{
	if (!confirm("Are you sure you want to delete this Mail Group?")) return false; else ShowProgressDialog('Deleting Mail Group...');
}
</script>

<div class="card-body form-horizontal">

    <dnc:EmailAddress id="emailAddress" runat="server"></dnc:EmailAddress>
    <asp:PlaceHolder ID="providerControl" runat="server"></asp:PlaceHolder>

</div>
<div class="card-footer text-end">
    <asp:LinkButton id="btnDelete" CssClass="btn btn-danger" runat="server" CausesValidation="False" OnClick="btnDelete_Click" OnClientClick="return confirmation();"> <i class="bi bi-trash">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnDeleteText"/> </asp:LinkButton>&nbsp;
    <asp:LinkButton id="btnCancel" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnCancel_Click"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancel"/> </asp:LinkButton>&nbsp;
    <asp:LinkButton id="btnSave" CssClass="btn btn-success" runat="server" OnClick="btnSave_Click" OnClientClick="ShowProgressDialog('Saving Mail Group...');"> <i class="bi bi-floppy">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnSaveText" /> </asp:LinkButton>
</div>

