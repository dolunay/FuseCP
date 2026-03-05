<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SpaceImportResources.ascx.cs" Inherits="FuseCP.Portal.SpaceImportResources" %>
<%@ Register Src="UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport" TagPrefix="fcp" %>
<fcp:EnableAsyncTasksSupport id="asyncTasks" runat="server" />

<script type="text/javascript">
    function TreeViewCheckBoxClicked(Check_Event) 
    {
        var objElement;
        try {
            objElement = window.event.srcElement;
        }
        catch (Error) 
        {
        }

        if (objElement != null) 
        {
            if (objElement.tagName == "IMG" && objElement.href.indexOf('folder.png') == -1 && objElement.href.indexOf('empty.gif') == -1) {
                ShowProgressDialog('');
                ShowProgressDialogInternal();
            }
        }
        else 
        {
            if (Check_Event != null) 
            {
                if (Check_Event.target.tagName == "IMG" && Check_Event.target.href.indexOf('folder.png') == -1 && objElement.href.indexOf('empty.gif') == -1)
                {
                    ShowProgressDialog('');
                    ShowProgressDialogInternal();
                }
            }
        }
    }
</script>

<div class="card-body form-horizontal">
	<asp:treeview runat="server" id="tree" populatenodesfromclient="true" NodeIndent="10"
		showexpandcollapse="true" expanddepth="0" ontreenodepopulate="tree_TreeNodePopulate" OnTreeNodeCheckChanged="tree_TreeNodeCheckChanged" OnTreeNodeExpanded="tree_TreeNodeExpanded">
		<LevelStyles>
		    <asp:TreeNodeStyle CssClass="FileManagerTreeNode" />
		    <asp:TreeNodeStyle CssClass="FileManagerTreeNode" />
		</LevelStyles>
	</asp:treeview>
</div>
<div class="card-footer text-end">
    <asp:LinkButton id="btnCancel" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnCancel_Click"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancel"/> </asp:LinkButton>&nbsp;
    <asp:LinkButton id="btnImport" CssClass="btn btn-success" runat="server" OnClick="btnImport_Click" OnClientClick="return confirm('Proceed?');"> <i class="bi bi-check-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnImportText"/> </asp:LinkButton>
</div>
