<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SharedSSLEditFolder.ascx.cs" Inherits="FuseCP.Portal.SharedSSLEditFolder" %>
<%@ Register Src="WebSitesExtensionsControl.ascx" TagName="WebSitesExtensionsControl" TagPrefix="uc6" %>
<%@ Register Src="WebSitesCustomErrorsControl.ascx" TagName="WebSitesCustomErrorsControl" TagPrefix="uc4" %>
<%@ Register Src="WebSitesMimeTypesControl.ascx" TagName="WebSitesMimeTypesControl" TagPrefix="uc5" %>
<%@ Register Src="WebSitesHomeFolderControl.ascx" TagName="WebSitesHomeFolderControl" TagPrefix="uc1" %>
<%@ Register Src="WebSitesCustomHeadersControl.ascx" TagName="WebSitesCustomHeadersControl" TagPrefix="uc6" %>
<%@ Register Src="UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport" TagPrefix="fcp" %>
<fcp:EnableAsyncTasksSupport id="asyncTasks" runat="server"/>

<script type="text/javascript">

function confirmation() 
{
	if (!confirm("Are you sure you want to delete this Shared SSL Folder?")) return false; else ShowProgressDialog('Deleting Shared SSL Folder...');	
}
</script>

<div class="card-body form-horizontal">
    <div class="FormRow">
        <asp:HyperLink ID="lnkSiteName" runat="server" CssClass="Big" NavigateUrl="#" Target="_blank">domain.com/vdir</asp:HyperLink>
    </div>
    <div class="FormRow widget">
        <div class="widget-header clearfix">
        <table class="table table-borderless align-middle mb-0 w-100" width="100%">
            <tr>
                <td class="Tabs">
                    <asp:DataList ID="dlTabs" runat="server" RepeatDirection="Horizontal"
                        OnSelectedIndexChanged="dlTabs_SelectedIndexChanged" RepeatLayout="Flow">
                        <ItemStyle Wrap="False" />
                        <ItemTemplate>
                            <asp:LinkButton ID="cmdSelectTab" runat="server" CommandName="select" CssClass="Tab">
                                <%# Eval("Name") %>
                            </asp:LinkButton>
                        </ItemTemplate>
                        <SelectedItemStyle Wrap="False" />
                        <SelectedItemTemplate>
                            <asp:LinkButton ID="cmdSelectTab" runat="server" CommandName="select" CssClass="ActiveTab">
                                <%# Eval("Name") %>
                            </asp:LinkButton>
                        </SelectedItemTemplate>
                    </asp:DataList>
                </td>
            </tr>
        </table>
            </div>
        <div class="widget-content tab-content">
       <div class="card-body form-horizontal">
           <asp:MultiView ID="tabs" runat="server" ActiveViewIndex="0">
            <asp:View ID="tabHomeFolder" runat="server">
                <uc1:WebSitesHomeFolderControl ID="webSitesHomeFolderControl" runat="server" IsAppVirtualDirectory="true" />
            </asp:View>
            
            <asp:View ID="tabExtensions" runat="server">
                <uc6:WebSitesExtensionsControl ID="webSitesExtensionsControl" runat="server" IsAppVirtualDirectory="true" />
            </asp:View>
            
            <asp:View ID="tabErrors" runat="server">
                <uc4:WebSitesCustomErrorsControl ID="webSitesCustomErrorsControl" runat="server" />
            </asp:View>
            
            <asp:View ID="tabHeaders" runat="server">
                <uc6:WebSitesCustomHeadersControl ID="webSitesCustomHeadersControl" runat="server" />
            </asp:View>
            
            <asp:View ID="tabMimes" runat="server">
                <uc5:WebSitesMimeTypesControl ID="webSitesMimeTypesControl" runat="server" />
            </asp:View>
            
           </asp:MultiView>
       </div>
            </div>
    </div>
</div>
<div class="card-footer text-end">
    <asp:LinkButton id="btnDelete" CssClass="btn btn-danger" runat="server" CausesValidation="False" OnClick="btnDelete_Click" OnClientClick="confirmation();"> <i class="bi bi-trash">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnDeleteText"/> </asp:LinkButton>&nbsp;
    <asp:LinkButton id="btnCancel" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnCancel_Click"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancel"/> </asp:LinkButton>&nbsp;
    <asp:LinkButton id="btnUpdate" CssClass="btn btn-success" runat="server" OnClick="btnUpdate_Click" ValidationGroup="Server" OnclientClick="ShowProgressDialog('Saving Shared SSL Folder...')"> <i class="bi bi-arrow-clockwise">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnUpdateText"/> </asp:LinkButton>
</div>
