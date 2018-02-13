class Tenant < ApplicationRecord

   acts_as_universal_and_determines_tenant
  has_many :members, dependent: :destroy
  # also careful with this next line...
  # if tenant closes their account, this will destroy all projects
  has_many :projects, dependent: :destroy
  # als added name validation to ensure that user fills in a unique organization
  validates_uniqueness_of :name
  validates_presence_of :name

    def self.create_new_tenant(tenant_params, user_params, coupon_params)
      # als modified this next line so it could use our plans
      tenant = Tenant.new(tenant_params)

      if new_signups_not_permitted?(coupon_params)

        raise ::Milia::Control::MaxTenantExceeded, "Sorry, new accounts not permitted at this time" 

      else 
        tenant.save    # create the tenant
      end
      return tenant
    end

  # ------------------------------------------------------------------------
  # new_signups_not_permitted? -- returns true if no further signups allowed
  # args: params from user input; might contain a special 'coupon' code
  #       used to determine whether or not to allow another signup
  # ------------------------------------------------------------------------
  def self.new_signups_not_permitted?(params)
    return false
  end

  # ------------------------------------------------------------------------
  # tenant_signup -- setup a new tenant in the system
  # CALLBACK from devise RegistrationsController (milia override)
  # AFTER user creation and current_tenant established
  # args:
  #   user  -- new user  obj
  #   tenant -- new tenant obj
  #   other  -- any other parameter string from initial request
  # ------------------------------------------------------------------------
    def self.tenant_signup(user, tenant, other = nil)
      #  StartupJob.queue_startup( tenant, user, other )
      # any special seeding required for a new organizational tenant
      #
      Member.create_org_admin(user)
      #
    end

   
end
