<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ItemButtonPanel.ascx.cs" Inherits="FuseCP.Portal.ItemButtonPanel" %>
<asp:LinkButton id="btnSaveExit" runat="server"  CssClass="btn btn-success" 
    OnClick="btnSaveExit_Click" OnClientClick="ShowProgressDialog('Updating ...');">
    <i class="bi bi-check-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" id="btnSaveExitText" meta:resourcekey="btnSaveExit"/>
</asp:LinkButton>
<span class="float-end">&nbsp;</span>
<asp:LinkButton id="btnSave" runat="server"  CssClass="btn btn-success" 
    OnClick="btnSave_Click" OnClientClick="ShowProgressDialog('Updating ...');">
    <i class="bi bi-floppy">&nbsp;</i>&nbsp;<asp:Localize runat="server"  id="btnSaveText" meta:resourcekey="btnSave"/>
</asp:LinkButton>

