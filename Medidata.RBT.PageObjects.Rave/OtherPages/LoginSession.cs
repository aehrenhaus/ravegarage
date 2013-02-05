using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Medidata.RBT.PageObjects.Rave
{
	public class LoginSession : IDisposable
	{
		WebTestContext context;


		string previousUser;
		string previousPassword;
		public bool RestoreOriginalUser { get; set; }
		bool gobackToOriginalPage;
		IPage originalPage;

		/// <summary>
		/// 
		/// </summary>
		/// <param name="context"></param>
		/// <param name="username">If empty, will use configured username</param>
		/// <param name="passowrd">If empth, will use configured password</param>
		/// <param name="restoreOriginalUser">Will it login back as the previous user after the new login session</param>
		/// <param name="restoreOriginalPage">
		/// Will it goes back to the excact page that before the login session starts,
		/// If false, will only stays in home page. 
		/// This parameter is only useful when restoreOriginalUser is set to true.
		/// </param>
		public LoginSession(WebTestContext context, string username = null, string passowrd = null, bool restoreOriginalUser = true, bool restoreOriginalPage = false)
		{
			this.context = context;
            previousUser = context.CurrentUser ?? RaveConfiguration.Default.DefaultUser;
			previousPassword = context.CurrentUserPassword ?? RaveConfiguration.Default.DefaultUserPassword;
			originalPage = context.CurrentPage;

			this.RestoreOriginalUser = restoreOriginalUser;
			this.gobackToOriginalPage = restoreOriginalPage;
			LoginPage.LoginToHomePageIfNotAlready(context, username, passowrd);
		}

		public void Dispose()
		{
			if (previousUser != null && RestoreOriginalUser)
			{
				LoginPage.LoginToHomePageIfNotAlready(context, previousUser, previousPassword);

				if (gobackToOriginalPage)
				{
					context.CurrentPage = originalPage.NavigateToSelf();
				}
			}
		}
	}
}
