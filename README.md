# NAME

BmltClient::Role - a Moose role for the BMLT

BMLT Admin API Documentation

# VERSION

Automatically generated by the [OpenAPI Generator](https://openapi-generator.tech) project:

- API version: 1.0.0
- Package version: 1.0.0
- Build package: org.openapitools.codegen.languages.PerlClientCodegen

## A note on Moose

This role is the only component of the library that uses Moose. See
BmltClient::ApiFactory for non-Moosey usage.

# SYNOPSIS

The Perl Generator in the OpenAPI Generator project builds a library of Perl modules to interact with
a web service defined by a OpenAPI Specification. See below for how to build the
library.

This module provides an interface to the generated library. All the classes,
objects, and methods (well, not quite \*all\*, see below) are flattened into this
role.

        package MyApp;
        use Moose;
        with 'BmltClient::Role';

        package main;

        my $api = MyApp->new({ tokens => $tokens });

        my $pet = $api->get_pet_by_id(pet_id => $pet_id);


## Structure of the library

The library consists of a set of API classes, one for each endpoint. These APIs
implement the method calls available on each endpoint.

Additionally, there is a set of "object" classes, which represent the objects
returned by and sent to the methods on the endpoints.

An API factory class is provided, which builds instances of each endpoint API.

This Moose role flattens all the methods from the endpoint APIs onto the consuming
class. It also provides methods to retrieve the endpoint API objects, and the API
factory object, should you need it.

For documentation of all these methods, see AUTOMATIC DOCUMENTATION below.

## Configuring authentication

In the normal case, the OpenAPI Spec will describe what parameters are
required and where to put them. You just need to supply the tokens.

    my $tokens = {
        # basic
        username => $username,
        password => $password,

        # oauth
        access_token => $oauth_token,

        # keys
        $some_key => { token => $token,
                       prefix => $prefix,
                       in => $in,             # 'head||query',
                       },

        $another => { token => $token,
                      prefix => $prefix,
                      in => $in,              # 'head||query',
                      },
        ...,

        };

        my $api = MyApp->new({ tokens => $tokens });

Note these are all optional, as are `prefix` and `in`, and depend on the API
you are accessing. Usually `prefix` and `in` will be determined by the code generator from
the spec and you will not need to set them at run time. If not, `in` will
default to 'head' and `prefix` to the empty string.

The tokens will be placed in a L<BmltClient::Configuration> instance
as follows, but you don't need to know about this.

- `$cfg->{username}`

    String. The username for basic auth.

- `$cfg->{password}`

    String. The password for basic auth.

- `$cfg->{api_key}`

    Hashref. Keyed on the name of each key (there can be multiple tokens).

            $cfg->{api_key} = {
                    secretKey => 'aaaabbbbccccdddd',
                    anotherKey => '1111222233334444',
                    };

- `$cfg->{api_key_prefix}`

    Hashref. Keyed on the name of each key (there can be multiple tokens). Note not
    all api keys require a prefix.

            $cfg->{api_key_prefix} = {
                    secretKey => 'string',
                    anotherKey => 'same or some other string',
                    };

- `$cfg->{access_token}`

    String. The OAuth access token.

# METHODS

## `base_url`

The generated code has the `base_url` already set as a default value. This method
returns the current value of `base_url`.

## `api_factory`

Returns an API factory object. You probably won't need to call this directly.

        $self->api_factory('Pet'); # returns a BmltClient::PetApi instance

        $self->pet_api;            # the same

# MISSING METHODS

Most of the methods on the API are delegated to individual endpoint API objects
(e.g. Pet API, Store API, User API etc). Where different endpoint APIs use the
same method name (e.g. `new()`), these methods can't be delegated. So you need
to call `$api->pet_api->new()`.

In principle, every API is susceptible to the presence of a few, random, undelegatable
method names. In practice, because of the way method names are constructed, it's
unlikely in general that any methods will be undelegatable, except for:

        new()
        class_documentation()
        method_documentation()

To call these methods, you need to get a handle on the relevant object, either
by calling `$api->foo_api` or by retrieving an object, e.g.
`$api->get_pet_by_id(pet_id => $pet_id)`. They are class methods, so
you could also call them on class names.

# BUILDING YOUR LIBRARY

See the homepage `https://openapi-generator.tech` for full details.
But briefly, clone the git repository, build the codegen codebase, set up your build
config file, then run the API build script. You will need git, Java 7 or 8 and Apache
maven 3.0.3 or better already installed.

The config file should specify the project name for the generated library:

        {"moduleName":"WWW::MyProjectName"}

Your library files will be built under `WWW::MyProjectName`.

          $ git clone https://github.com/openapitools/openapi-generator
          $ cd openapi-generator
          $ mvn package
          $ java -jar modules/openapi-generator-cli/target/openapi-generator-cli.jar generate \
    -i [URL or file path to JSON OpenAPI API spec] \
    -g perl \
    -c /path/to/config/file.json \
    -o /path/to/output/folder

Bang, all done. Run the `autodoc` script in the `bin` directory to see the API
you just built.

# AUTOMATIC DOCUMENTATION

You can print out a summary of the generated API by running the included
`autodoc` script in the `bin` directory of your generated library. A few
output formats are supported:

          Usage: autodoc [OPTION]

    -w           wide format (default)
    -n           narrow format
    -p           POD format
    -H           HTML format
    -m           Markdown format
    -h           print this help message
    -c           your application class


The `-c` option allows you to load and inspect your own application. A dummy
namespace is used if you don't supply your own class.

# DOCUMENTATION FROM THE OpenAPI Spec

Additional documentation for each class and method may be provided by the OpenAPI
spec. If so, this is available via the `class_documentation()` and
`method_documentation()` methods on each generated object class, and the
`method_documentation()` method on the endpoint API classes:

        my $cmdoc = $api->pet_api->method_documentation->{$method_name};

        my $odoc = $api->get_pet_by_id->(pet_id => $pet_id)->class_documentation;
        my $omdoc = $api->get_pet_by_id->(pet_id => $pet_id)->method_documentation->{method_name};


Each of these calls returns a hashref with various useful pieces of information.

# Installation Prerequisites

Use [cpanm](https://metacpan.org/pod/distribution/App-cpanminus/bin/cpanm) to install the module dependencies:

```
cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
cpanm --quiet --no-interactive Class::Accessor Test::Exception Test::More Log::Any LWP::UserAgent URI::Query Module::Runtime DateTime Module::Find Moose::Role JSON
```

# LOAD THE MODULES

To load the API packages:
```perl
use BmltClient::RootServerApi;

```

To load the models:
```perl
use BmltClient::Object::AuthenticationError;
use BmltClient::Object::AuthorizationError;
use BmltClient::Object::Format;
use BmltClient::Object::FormatAllOf;
use BmltClient::Object::FormatBase;
use BmltClient::Object::FormatCreate;
use BmltClient::Object::FormatPartialUpdate;
use BmltClient::Object::FormatTranslation;
use BmltClient::Object::FormatUpdate;
use BmltClient::Object::Meeting;
use BmltClient::Object::MeetingBase;
use BmltClient::Object::MeetingCreate;
use BmltClient::Object::MeetingPartialUpdate;
use BmltClient::Object::MeetingUpdate;
use BmltClient::Object::NotFoundError;
use BmltClient::Object::ServiceBody;
use BmltClient::Object::ServiceBodyBase;
use BmltClient::Object::ServiceBodyCreate;
use BmltClient::Object::ServiceBodyPartialUpdate;
use BmltClient::Object::ServiceBodyUpdate;
use BmltClient::Object::Token;
use BmltClient::Object::TokenCredentials;
use BmltClient::Object::User;
use BmltClient::Object::UserBase;
use BmltClient::Object::UserCreate;
use BmltClient::Object::UserCreateAllOf;
use BmltClient::Object::UserPartialUpdate;
use BmltClient::Object::UserUpdate;
use BmltClient::Object::ValidationError;

````

# GETTING STARTED
Put the Perl SDK under the 'lib' folder in your project directory, then run the following
```perl
#!/usr/bin/perl
use lib 'lib';
use strict;
use warnings;
# load the API package
use BmltClient::RootServerApi;

# load the models
use BmltClient::Object::AuthenticationError;
use BmltClient::Object::AuthorizationError;
use BmltClient::Object::Format;
use BmltClient::Object::FormatAllOf;
use BmltClient::Object::FormatBase;
use BmltClient::Object::FormatCreate;
use BmltClient::Object::FormatPartialUpdate;
use BmltClient::Object::FormatTranslation;
use BmltClient::Object::FormatUpdate;
use BmltClient::Object::Meeting;
use BmltClient::Object::MeetingBase;
use BmltClient::Object::MeetingCreate;
use BmltClient::Object::MeetingPartialUpdate;
use BmltClient::Object::MeetingUpdate;
use BmltClient::Object::NotFoundError;
use BmltClient::Object::ServiceBody;
use BmltClient::Object::ServiceBodyBase;
use BmltClient::Object::ServiceBodyCreate;
use BmltClient::Object::ServiceBodyPartialUpdate;
use BmltClient::Object::ServiceBodyUpdate;
use BmltClient::Object::Token;
use BmltClient::Object::TokenCredentials;
use BmltClient::Object::User;
use BmltClient::Object::UserBase;
use BmltClient::Object::UserCreate;
use BmltClient::Object::UserCreateAllOf;
use BmltClient::Object::UserPartialUpdate;
use BmltClient::Object::UserUpdate;
use BmltClient::Object::ValidationError;

# for displaying the API response data
use Data::Dumper;


my $api_instance = BmltClient::RootServerApi->new(
    # Configure OAuth2 access token for authorization: bmltToken
    access_token => 'YOUR_ACCESS_TOKEN',
);


eval {
    $api_instance->auth_logout();
};
if ($@) {
    warn "Exception when calling RootServerApi->auth_logout: $@\n";
}

```

# DOCUMENTATION FOR API ENDPOINTS

All URIs are relative to *http://localhost:8000/main_server*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*RootServerApi* | [**auth_logout**](docs/RootServerApi.md#auth_logout) | **POST** /api/v1/auth/logout | Revokes a token
*RootServerApi* | [**auth_refresh**](docs/RootServerApi.md#auth_refresh) | **POST** /api/v1/auth/refresh | Revokes and issues a new token
*RootServerApi* | [**auth_token**](docs/RootServerApi.md#auth_token) | **POST** /api/v1/auth/token | Creates a token
*RootServerApi* | [**create_format**](docs/RootServerApi.md#create_format) | **POST** /api/v1/formats | Creates a format
*RootServerApi* | [**create_meeting**](docs/RootServerApi.md#create_meeting) | **POST** /api/v1/meetings | Creates a meeting
*RootServerApi* | [**create_service_body**](docs/RootServerApi.md#create_service_body) | **POST** /api/v1/servicebodies | Creates a service body
*RootServerApi* | [**create_user**](docs/RootServerApi.md#create_user) | **POST** /api/v1/users | Creates a user
*RootServerApi* | [**delete_format**](docs/RootServerApi.md#delete_format) | **DELETE** /api/v1/formats/{formatId} | Deletes a format
*RootServerApi* | [**delete_meeting**](docs/RootServerApi.md#delete_meeting) | **DELETE** /api/v1/meetings/{meetingId} | Deletes a meeting
*RootServerApi* | [**delete_service_body**](docs/RootServerApi.md#delete_service_body) | **DELETE** /api/v1/servicebodies/{serviceBodyId} | Deletes a service body
*RootServerApi* | [**delete_user**](docs/RootServerApi.md#delete_user) | **DELETE** /api/v1/users/{userId} | Deletes a user
*RootServerApi* | [**get_format**](docs/RootServerApi.md#get_format) | **GET** /api/v1/formats/{formatId} | Retrieves a format
*RootServerApi* | [**get_formats**](docs/RootServerApi.md#get_formats) | **GET** /api/v1/formats | Retrieves formats
*RootServerApi* | [**get_meeting**](docs/RootServerApi.md#get_meeting) | **GET** /api/v1/meetings/{meetingId} | Retrieves a meeting
*RootServerApi* | [**get_meetings**](docs/RootServerApi.md#get_meetings) | **GET** /api/v1/meetings | Retrieves meetings
*RootServerApi* | [**get_service_bodies**](docs/RootServerApi.md#get_service_bodies) | **GET** /api/v1/servicebodies | Retrieves service bodies
*RootServerApi* | [**get_service_body**](docs/RootServerApi.md#get_service_body) | **GET** /api/v1/servicebodies/{serviceBodyId} | Retrieves a service body
*RootServerApi* | [**get_user**](docs/RootServerApi.md#get_user) | **GET** /api/v1/users/{userId} | Retrieves a single user
*RootServerApi* | [**get_users**](docs/RootServerApi.md#get_users) | **GET** /api/v1/users | Retrieves users
*RootServerApi* | [**partial_update_user**](docs/RootServerApi.md#partial_update_user) | **PATCH** /api/v1/users/{userId} | Patches a user
*RootServerApi* | [**patch_format**](docs/RootServerApi.md#patch_format) | **PATCH** /api/v1/formats/{formatId} | Patches a format
*RootServerApi* | [**patch_meeting**](docs/RootServerApi.md#patch_meeting) | **PATCH** /api/v1/meetings/{meetingId} | Patches a meeting
*RootServerApi* | [**patch_service_body**](docs/RootServerApi.md#patch_service_body) | **PATCH** /api/v1/servicebodies/{serviceBodyId} | Patches a service body
*RootServerApi* | [**update_format**](docs/RootServerApi.md#update_format) | **PUT** /api/v1/formats/{formatId} | Updates a format
*RootServerApi* | [**update_meeting**](docs/RootServerApi.md#update_meeting) | **PUT** /api/v1/meetings/{meetingId} | Updates a meeting
*RootServerApi* | [**update_service_body**](docs/RootServerApi.md#update_service_body) | **PUT** /api/v1/servicebodies/{serviceBodyId} | Updates a Service Body
*RootServerApi* | [**update_user**](docs/RootServerApi.md#update_user) | **PUT** /api/v1/users/{userId} | Update single user


# DOCUMENTATION FOR MODELS
 - [BmltClient::Object::AuthenticationError](docs/AuthenticationError.md)
 - [BmltClient::Object::AuthorizationError](docs/AuthorizationError.md)
 - [BmltClient::Object::Format](docs/Format.md)
 - [BmltClient::Object::FormatAllOf](docs/FormatAllOf.md)
 - [BmltClient::Object::FormatBase](docs/FormatBase.md)
 - [BmltClient::Object::FormatCreate](docs/FormatCreate.md)
 - [BmltClient::Object::FormatPartialUpdate](docs/FormatPartialUpdate.md)
 - [BmltClient::Object::FormatTranslation](docs/FormatTranslation.md)
 - [BmltClient::Object::FormatUpdate](docs/FormatUpdate.md)
 - [BmltClient::Object::Meeting](docs/Meeting.md)
 - [BmltClient::Object::MeetingBase](docs/MeetingBase.md)
 - [BmltClient::Object::MeetingCreate](docs/MeetingCreate.md)
 - [BmltClient::Object::MeetingPartialUpdate](docs/MeetingPartialUpdate.md)
 - [BmltClient::Object::MeetingUpdate](docs/MeetingUpdate.md)
 - [BmltClient::Object::NotFoundError](docs/NotFoundError.md)
 - [BmltClient::Object::ServiceBody](docs/ServiceBody.md)
 - [BmltClient::Object::ServiceBodyBase](docs/ServiceBodyBase.md)
 - [BmltClient::Object::ServiceBodyCreate](docs/ServiceBodyCreate.md)
 - [BmltClient::Object::ServiceBodyPartialUpdate](docs/ServiceBodyPartialUpdate.md)
 - [BmltClient::Object::ServiceBodyUpdate](docs/ServiceBodyUpdate.md)
 - [BmltClient::Object::Token](docs/Token.md)
 - [BmltClient::Object::TokenCredentials](docs/TokenCredentials.md)
 - [BmltClient::Object::User](docs/User.md)
 - [BmltClient::Object::UserBase](docs/UserBase.md)
 - [BmltClient::Object::UserCreate](docs/UserCreate.md)
 - [BmltClient::Object::UserCreateAllOf](docs/UserCreateAllOf.md)
 - [BmltClient::Object::UserPartialUpdate](docs/UserPartialUpdate.md)
 - [BmltClient::Object::UserUpdate](docs/UserUpdate.md)
 - [BmltClient::Object::ValidationError](docs/ValidationError.md)


# DOCUMENTATION FOR AUTHORIZATION

## bmltToken

- **Type**: OAuth
- **Flow**: password
- **Authorization URL**: 
- **Scopes**: N/A
