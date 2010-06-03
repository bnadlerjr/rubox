require "xmlsimple"

module Rubox
  # == Description
  # Parses the response from a Box.net API call.
  class Parser
    # Initializes the +Parser+.
    #
    # response:: The XML response from the Box.net API call.
    def initialize(response)
      @xml = XmlSimple.xml_in(response, 'ForceArray' => false)
    end

    # Parses the response from +get_ticket+ action. Used in the authentication
    # process. Returns a ticket that is used to generate an authentication page
    # for the user to login.
    def get_ticket
      @xml['ticket'].to_s
    end

    # Parses the response from +get_auth_token+ action. Returns an
    # authentication token that is used in the authorization process, after the
    # user has authorized on the Box.net partner authentication page.
    def get_auth_token
      @xml['auth_token'].to_s
    end

    # Parses the response given when the +logout+ action has been called. 
    # Returns +true+ if successful. otherwise +False+.
    def logout
      'logout_ok' == @xml['status'].to_s ? true : false
    end

    # Parses the response given when the +register_new_user+ action has been 
    # called. Returns +true+ if the registration was successful, otherwise 
    # +false+.
    def register_new_user
      'successful_register' == @xml['status'].to_s ? true : false
    end

    # Parses the response given when the +verify_registration_email+ action has
    # been called. Returns +true+ if the user email is available or +false+ if
    # already in use.
    def verify_registration_email
      'email_ok' == @xml['status'].to_s ? true : false
    end

    # Parses the response given when the +get_account_info+ action has been 
    # called. Returns a +User+ object containing the user's information.
    def get_account_info
      User.load_from_xml(@xml)
    end

    # Parses the response given when the +get_account_tree+ action has been 
    # invoked. Returns a +Folder+ object containing the entire folder tree for
    # the account.
    def get_account_tree
      Folder.build_from_xml(@xml['tree']['folder'])
    end

    # Parses the response given when the +create_folder+ action has been 
    # invoked. Returns +true+ if the folder was successfully created, otherwise
    # +false+.
    def create_folder
      'create_ok' == @xml['status'] ? true : false
    end

    # Parses the response given when the +move+ action has been invoked. 
    # Returns +true+ if the move was successful, otherwise +false+.
    def move
      's_move_node' == @xml['status'] ? true : false
    end

    # Parses the response given when the +copy+ action has been invoked. 
    # Returns +true+ if the copy operation was successful, otherwise +false+.
    def copy
      's_copy_node' == @xml['status'] ? true : false
    end

    # Parses the response given when the +rename+ action has been invoked. 
    # Returns +true+ if the operation was successful, otherwise +false+.
    def rename
      's_rename_node' == @xml['status'] ? true : false
    end

    # Parses the response given when the +delete+ action has been called. 
    # Returns +true+ if the delete was successful, otherwise +false+.
    def delete
      's_delete_node' == @xml['status'] ? true : false
    end

    # Parses the response given when the +get_file_info+ action has been 
    # called. Returns an +Info+ object containing the file information.
    def get_file_info
      Info.build_from_xml(@xml['info'])
    end

    # Parses the response given when the +set_description+ action has been 
    # called. Returns +true+ if successful, otherwise +false+.
    def set_description
      's_set_description' == @xml['status'] ? true : false
    end

    # Parses the response given when the +public_share+ action has been 
    # called. Returns the unique identifier of the publicly shared file.
    def public_share
      @xml['public_name'].to_s
    end

    # Parses the response given when the +public_unshare+ action has been 
    # called. Returns +true+ if successful, otherwise +false+.
    def public_unshare
      'unshare_ok' == @xml['status'] ? true : false
    end

    # Parses the response given when the +private_share+ action has been 
    # invoked. Returns +true+ if successful, otherwise +false+.
    def private_share
      'private_share_ok' == @xml['status'] ? true : false
    end

    # Parses the response given when the +request_friends+ action has been
    # called. Returns +true+ if the friends were successfully added, otherwise
    # +false+.
    def request_friends
      's_request_friends' == @xml['status'] ? true : false
    end

    # Parses the response given when the +get_friends+ action has been called. 
    # Returns an array of +Friend+ objects.
    def get_friends
      @xml['friends']['friends'].map { |f| Friend.build_from_xml(f[1]) }
    end

    # Parses the response given when the +add_to_mybox+ action is invoked. 
    # Returns +true+ if the file operation was successful, otherwise +false+.
    def add_to_mybox
      'addtomybox_ok' == @xml['status'] ? true : false
    end
  end
end
