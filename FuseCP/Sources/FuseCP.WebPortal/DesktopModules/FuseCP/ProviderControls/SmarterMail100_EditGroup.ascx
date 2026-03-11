<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SmarterMail100_EditGroup.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.SmarterMail100_EditGroup" %>
<%@ Register TagPrefix="dnc" TagName="EditItemsList" Src="../MailEditItems.ascx" %>
<div class="row mb-3">
		    <asp:Label ID="lblGroupMembers" CssClass="form-label col-sm-2" runat="server" meta:resourcekey="lblGroupMembers" Text="Group e-mails:"></asp:Label>
		<div class="input-group col-sm-8">
			<dnc:EditItemsList id="mailEditItems" runat="server"></dnc:EditItemsList>
        </div>
</div>
