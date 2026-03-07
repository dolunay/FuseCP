<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DomainsImportZone.ascx.cs" Inherits="FuseCP.Portal.DomainsImportZone" %>
<%@ Register Src="UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport" TagPrefix="fcp" %>

<fcp:EnableAsyncTasksSupport id="asyncTasks" runat="server" />

<asp:Panel ID="pnlImport" runat="server">
    <div class="card-body form-horizontal">
        <div class="Huge p-2 border bg-light">
            <asp:Literal ID="litDomainName" runat="server"></asp:Literal>
        </div>
    </div>
    <fieldset id="ImportPanel" runat="server" visible="True">
        <div class="FormRow" runat="server">
            <div class="col-md-12">
                <label for="file">Zone file to upload</label>
                <input id="file" type="file" name="zoneFile" runat="server" required/>
                <br/>
                <asp:LinkButton ID="UploadZoneFile" runat="server" CssClass="btn btn-primary"
                                  Text="Upload zone file"
                                  OnClientClick="ShowProgressDialog('Uploading zone file');"
                                  OnClick="UploadZoneFile_OnClick"></asp:LinkButton>
                <br/>
                <br/>
            </div>
        </div>
    </fieldset>
</asp:Panel>
