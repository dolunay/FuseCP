<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VirtualDirectoryHomeFolderControl.ascx.cs" Inherits="FuseCP.Portal.VirtualDirectoryHomeFolderControl" %>
<%@ Register Src="UserControls/FileLookup.ascx" TagName="FileLookup" TagPrefix="uc1" %>
<div style="padding: 20px">
<table>

	<tr>
	    <td class="text-nowrap"></td>
	    <td>
	        <table id="tblFolder" runat="server">
	            <tr>
	                <td colspan="3">
			            <table>
				            <tr>
					            <td class="Normal text-nowrap align-top" style="padding-top:7px">
					                <asp:Label ID="lblSitePath" runat="server" meta:resourcekey="lblSitePath" Text="Content Path: "></asp:Label>&nbsp;
					            </td>
					            <td class="align-top">
                                    <uc1:FileLookup ID="fileLookup" runat="server" />
                                </td>
				            </tr>
			            </table>     
	                </td>
	            </tr>
	            <tr>
	                <td colspan="3" class="Normal">&nbsp;</td>
	            </tr>
	            <tr>
	                <td class="Normal align-top">
			            <asp:PlaceHolder runat="server" id="pnlCustomAuth">
			            <br />
			            <table class="Normal table table-borderless align-middle mb-0">
			                <tr>
			                    <td class="NormalBold">
			                        <asp:Label ID="lblAuthentication" runat="server" meta:resourcekey="lblAuthentication" Text="Authentication:"></asp:Label>
			                    </td>
			                </tr>
                            <tr>
	                            <td class="text-nowrap"><asp:checkbox id="chkAuthAnonymous" meta:resourcekey="chkAuthAnonymous" Text="Enable anonymous access" Runat="server"></asp:checkbox></td>
                            </tr>
                            <tr>
	                            <td class="text-nowrap"><asp:checkbox id="chkAuthWindows" meta:resourcekey="chkAuthWindows" Text="Integrated Windows authentication" Runat="server"></asp:checkbox></td>
                            </tr>
                            <tr>
	                            <td class="text-nowrap"><asp:checkbox id="chkAuthBasic" meta:resourcekey="chkAuthBasic" Text="Basic authentication" Runat="server"></asp:checkbox></td>
                            </tr>
                        </table>
			            </asp:PlaceHolder>
	                </td>
	            </tr>
	        </table>
	    </td>
	</tr>
</table>
</div>
