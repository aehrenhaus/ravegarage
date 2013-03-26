using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Principal;

namespace Medidata.RBT.Features.BatchUploader.Helpers
{
	class BatchUploadFileHelper
	{
		#region Public Methods

		public static bool CheckFileProcessedInTargetDirectory(string fileName, string targetDirectoryName, int timeout)
		{
			DateTime dtExpiry = DateTime.Now.AddMinutes(timeout);
			bool found = false;

			while (DateTime.Now < dtExpiry)
			{
				found = FileHelper.FileExistsInDirectory(fileName, targetDirectoryName);
				if (found)
				{
					System.Threading.Thread.Sleep(60000);
				}
				else
				{
					break;
				}
			}
			return !found;
		}




		//note: userName, password, and domain in plain text; dangerous******************
		public static bool CheckFileProcessedInTargetDirectoryWithImpersonation(string fileName, string targetDirectoryName, int timeout, string username, string password, string domain)
		{
			IntPtr tokenHandle = IntPtr.Zero;
			IntPtr duplicateTokenHandle = IntPtr.Zero;

			bool processed = false;
			try
			{
				WindowsIdentity identity = FileHelper.ImpersonateUser(username, password, domain, out tokenHandle, out duplicateTokenHandle);
				using (WindowsImpersonationContext context = identity.Impersonate())
				{
					processed = CheckFileProcessedInTargetDirectory(fileName, targetDirectoryName, timeout);
				}
				identity.Dispose();
			}
			catch (Exception ex)
			{
				ex.Data["targetDirectoryName"] = targetDirectoryName;
				throw;
			}
			finally
			{
				FileHelper.CleanUpImpersonation(tokenHandle, duplicateTokenHandle);
			}
			return processed;

		}





		#endregion Public Methods
	}
}
