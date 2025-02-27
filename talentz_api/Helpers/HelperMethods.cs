namespace talentz_api.Helpers
{
    public static class HelperMethods
    {
        public static T? ConvertFromDBVal<T>(object obj)
        {
            if (obj == null || obj == DBNull.Value)
            {
                return default;
            }
            else
            {
                return (T)obj;
            }
        }

        public static bool CheckRoles(List<string> validRoles, string roleToCheck)
        {
            foreach (string role in validRoles)
            {
                if (string.IsNullOrEmpty(role))
                {
                    continue;
                }
                else if (role == roleToCheck)
                {
                    return true;
                }
                else
                {
                    continue;
                }
            }

            return false;
        }

        public static dynamic? NotDefaultOrNull<T>(dynamic? value)
        {
            return default(T) == value ? null : value;
        }

        public static dynamic? NotDefaultOrEmptyString<T>(dynamic? value)
        {
            return default(T) == value ? "" : value;
        }

        public static dynamic? ShowIfRoles(List<string> roles, string roleToCheck, object value)
        {
            if (CheckRoles(roles, roleToCheck))
            {
                return value;
            }
            return null;
        }
    }
}
