=begin comment

BMLT

BMLT Admin API Documentation

The version of the OpenAPI document: 1.0.0

Generated by: https://openapi-generator.tech

=end comment

=cut

#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# Do not edit the class manually.
# Ref: https://openapi-generator.tech
#
package bmlt-cli::Object::MeetingCreate;

require 5.6.0;
use strict;
use warnings;
use utf8;
use JSON qw(decode_json);
use Data::Dumper;
use Module::Runtime qw(use_module);
use Log::Any qw($log);
use Date::Parse;
use DateTime;


use base ("Class::Accessor", "Class::Data::Inheritable");

#
#
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech). Do not edit the class manually.
# REF: https://openapi-generator.tech
#

=begin comment

BMLT

BMLT Admin API Documentation

The version of the OpenAPI document: 1.0.0

Generated by: https://openapi-generator.tech

=end comment

=cut

#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# Do not edit the class manually.
# Ref: https://openapi-generator.tech
#
__PACKAGE__->mk_classdata('attribute_map' => {});
__PACKAGE__->mk_classdata('openapi_types' => {});
__PACKAGE__->mk_classdata('method_documentation' => {});
__PACKAGE__->mk_classdata('class_documentation' => {});

# new plain object
sub new {
    my ($class, %args) = @_;

    my $self = bless {}, $class;

    $self->init(%args);

    return $self;
}

# initialize the object
sub init
{
    my ($self, %args) = @_;

    foreach my $attribute (keys %{$self->attribute_map}) {
        my $args_key = $self->attribute_map->{$attribute};
        $self->$attribute( $args{ $args_key } );
    }
}

# return perl hash
sub to_hash {
    my $self = shift;
    my $_hash = decode_json(JSON->new->convert_blessed->encode($self));

    return $_hash;
}

# used by JSON for serialization
sub TO_JSON {
    my $self = shift;
    my $_data = {};
    foreach my $_key (keys %{$self->attribute_map}) {
        if (defined $self->{$_key}) {
            my $_json_attribute = $self->attribute_map->{$_key};
            my $_type = $self->openapi_types->{$_key};
            my $_value = $self->{$_key};
            if ($_type =~ /^array\[(.+)\]$/i) { # array
                my $_subclass = $1;
                $_data->{$_json_attribute} =  [ map { $self->_to_json_primitives($_subclass, $_) } @$_value ];
            } elsif ($_type =~ /^hash\[string,(.+)\]$/i) { # hash
                my $_subclass = $1;
                my %_hash = ();
                while (my($_key, $_element) = each %{$_value}) {
                    $_hash{$_key} = $self->_to_json_primitives($_subclass, $_element);
                }
                $_data->{$_json_attribute} = \%_hash;
            } elsif ( grep( /^$_type$/, ('int', 'double', 'string', 'boolean', 'DATE', 'DATE_TIME'))) {
                $_data->{$_json_attribute} = $self->_to_json_primitives($_type, $_value);
            } else {
                $_data->{$_json_attribute} = $_value;
            }
        }
    }

    return $_data;
}

# to_json non-array data
sub _to_json_primitives {
    my ($self, $type, $data) = @_;
    if ( grep( /^$type$/, ('int', 'double'))) {
        # https://metacpan.org/pod/JSON#simple-scalars
        # numify it, ensuring it will be dumped as a number
        return undef unless defined $data;
        return $data + 0;
    } elsif ($type eq 'string') {
        # https://metacpan.org/pod/JSON#simple-scalars
        # stringified
        return undef unless defined $data;
        return $data . q();
    } elsif ($type eq 'boolean') {
        # https://metacpan.org/pod/JSON#JSON::true,-JSON::false,-JSON::null
        return $data ? \1 : \0;
    } elsif ($type eq 'DATE') {
        return undef unless defined $data;
        if (ref($data) eq 'DateTime') {
            # https://metacpan.org/pod/DateTime#$dt-%3Eymd($optional_separator),-$dt-%3Emdy(...),-$dt-%3Edmy(...)
            return $data->ymd;
        }
        return $data .q();
    } elsif ($type eq 'DATE_TIME') {
        return undef unless defined $data;
        # the date-time notation as defined by RFC 3339, section 5.6, for example, 2017-07-21T17:32:28Z
        if (ref($data) eq 'DateTime') {
            # https://metacpan.org/pod/DateTime#$dt-%3Erfc3339
            return $data->rfc3339;
        }
        return $data .q();
    } else { # hash (model),  In this case, the TO_JSON of the $data object is executed
        return $data;
    }
}

# from Perl hashref
sub from_hash {
    my ($self, $hash) = @_;

    # loop through attributes and use openapi_types to deserialize the data
    while ( my ($_key, $_type) = each %{$self->openapi_types} ) {
        my $_json_attribute = $self->attribute_map->{$_key};
        if ($_type =~ /^array\[(.+)\]$/i) { # array
            my $_subclass = $1;
            my @_array = ();
            foreach my $_element (@{$hash->{$_json_attribute}}) {
                push @_array, $self->_deserialize($_subclass, $_element);
            }
            $self->{$_key} = \@_array;
        } elsif ($_type =~ /^hash\[string,(.+)\]$/i) { # hash
            my $_subclass = $1;
            my %_hash = ();
            while (my($_key, $_element) = each %{$hash->{$_json_attribute}}) {
                $_hash{$_key} = $self->_deserialize($_subclass, $_element);
            }
            $self->{$_key} = \%_hash;
        } elsif (exists $hash->{$_json_attribute}) { #hash(model), primitive, datetime
            $self->{$_key} = $self->_deserialize($_type, $hash->{$_json_attribute});
        } else {
            $log->debugf("Warning: %s (%s) does not exist in input hash\n", $_key, $_json_attribute);
        }
    }

    return $self;
}

# deserialize non-array data
sub _deserialize {
    my ($self, $type, $data) = @_;
    $log->debugf("deserializing %s with %s",Dumper($data), $type);

    if (grep( /^$type$/ , ('DATE_TIME', 'DATE'))) {
        return DateTime->from_epoch(epoch => str2time($data));
    } elsif ( grep( /^$type$/, ('int', 'double'))) {
        return undef unless defined $data;
        return $data + 0;
    } elsif ($type eq 'string') {
        return undef unless defined $data;
        return $data . q();
    } elsif ($type eq 'boolean') {
        return !!$data;
    } else { # hash(model)
        my $_instance = eval "bmlt-cli::Object::$type->new()";
        return $_instance->from_hash($data);
    }
}


__PACKAGE__->class_documentation({description => '',
                                  class => 'MeetingCreate',
                                  required => [], # TODO
}                                 );

__PACKAGE__->method_documentation({
    'service_body_id' => {
        datatype => 'int',
        base_name => 'serviceBodyId',
        description => '',
        format => '',
        read_only => '',
            },
    'format_ids' => {
        datatype => 'ARRAY[int]',
        base_name => 'formatIds',
        description => '',
        format => '',
        read_only => '',
            },
    'venue_type' => {
        datatype => 'int',
        base_name => 'venueType',
        description => '',
        format => '',
        read_only => '',
            },
    'temporarily_virtual' => {
        datatype => 'boolean',
        base_name => 'temporarilyVirtual',
        description => '',
        format => '',
        read_only => '',
            },
    'day' => {
        datatype => 'int',
        base_name => 'day',
        description => '',
        format => '',
        read_only => '',
            },
    'start_time' => {
        datatype => 'string',
        base_name => 'startTime',
        description => '',
        format => '',
        read_only => '',
            },
    'duration' => {
        datatype => 'string',
        base_name => 'duration',
        description => '',
        format => '',
        read_only => '',
            },
    'time_zone' => {
        datatype => 'string',
        base_name => 'timeZone',
        description => '',
        format => '',
        read_only => '',
            },
    'latitude' => {
        datatype => 'double',
        base_name => 'latitude',
        description => '',
        format => '',
        read_only => '',
            },
    'longitude' => {
        datatype => 'double',
        base_name => 'longitude',
        description => '',
        format => '',
        read_only => '',
            },
    'published' => {
        datatype => 'boolean',
        base_name => 'published',
        description => '',
        format => '',
        read_only => '',
            },
    'email' => {
        datatype => 'string',
        base_name => 'email',
        description => '',
        format => '',
        read_only => '',
            },
    'world_id' => {
        datatype => 'string',
        base_name => 'worldId',
        description => '',
        format => '',
        read_only => '',
            },
    'name' => {
        datatype => 'string',
        base_name => 'name',
        description => '',
        format => '',
        read_only => '',
            },
    'location_text' => {
        datatype => 'string',
        base_name => 'location_text',
        description => '',
        format => '',
        read_only => '',
            },
    'location_info' => {
        datatype => 'string',
        base_name => 'location_info',
        description => '',
        format => '',
        read_only => '',
            },
    'location_street' => {
        datatype => 'string',
        base_name => 'location_street',
        description => '',
        format => '',
        read_only => '',
            },
    'location_neighborhood' => {
        datatype => 'string',
        base_name => 'location_neighborhood',
        description => '',
        format => '',
        read_only => '',
            },
    'location_city_subsection' => {
        datatype => 'string',
        base_name => 'location_city_subsection',
        description => '',
        format => '',
        read_only => '',
            },
    'location_municipality' => {
        datatype => 'string',
        base_name => 'location_municipality',
        description => '',
        format => '',
        read_only => '',
            },
    'location_sub_province' => {
        datatype => 'string',
        base_name => 'location_sub_province',
        description => '',
        format => '',
        read_only => '',
            },
    'location_province' => {
        datatype => 'string',
        base_name => 'location_province',
        description => '',
        format => '',
        read_only => '',
            },
    'location_postal_code_1' => {
        datatype => 'string',
        base_name => 'location_postal_code_1',
        description => '',
        format => '',
        read_only => '',
            },
    'location_nation' => {
        datatype => 'string',
        base_name => 'location_nation',
        description => '',
        format => '',
        read_only => '',
            },
    'phone_meeting_number' => {
        datatype => 'string',
        base_name => 'phone_meeting_number',
        description => '',
        format => '',
        read_only => '',
            },
    'virtual_meeting_link' => {
        datatype => 'string',
        base_name => 'virtual_meeting_link',
        description => '',
        format => '',
        read_only => '',
            },
    'virtual_meeting_additional_info' => {
        datatype => 'string',
        base_name => 'virtual_meeting_additional_info',
        description => '',
        format => '',
        read_only => '',
            },
    'contact_name_1' => {
        datatype => 'string',
        base_name => 'contact_name_1',
        description => '',
        format => '',
        read_only => '',
            },
    'contact_name_2' => {
        datatype => 'string',
        base_name => 'contact_name_2',
        description => '',
        format => '',
        read_only => '',
            },
    'contact_phone_1' => {
        datatype => 'string',
        base_name => 'contact_phone_1',
        description => '',
        format => '',
        read_only => '',
            },
    'contact_phone_2' => {
        datatype => 'string',
        base_name => 'contact_phone_2',
        description => '',
        format => '',
        read_only => '',
            },
    'contact_email_1' => {
        datatype => 'string',
        base_name => 'contact_email_1',
        description => '',
        format => '',
        read_only => '',
            },
    'contact_email_2' => {
        datatype => 'string',
        base_name => 'contact_email_2',
        description => '',
        format => '',
        read_only => '',
            },
    'bus_lines' => {
        datatype => 'string',
        base_name => 'bus_lines',
        description => '',
        format => '',
        read_only => '',
            },
    'train_line' => {
        datatype => 'string',
        base_name => 'train_line',
        description => '',
        format => '',
        read_only => '',
            },
    'comments' => {
        datatype => 'string',
        base_name => 'comments',
        description => '',
        format => '',
        read_only => '',
            },
});

__PACKAGE__->openapi_types( {
    'service_body_id' => 'int',
    'format_ids' => 'ARRAY[int]',
    'venue_type' => 'int',
    'temporarily_virtual' => 'boolean',
    'day' => 'int',
    'start_time' => 'string',
    'duration' => 'string',
    'time_zone' => 'string',
    'latitude' => 'double',
    'longitude' => 'double',
    'published' => 'boolean',
    'email' => 'string',
    'world_id' => 'string',
    'name' => 'string',
    'location_text' => 'string',
    'location_info' => 'string',
    'location_street' => 'string',
    'location_neighborhood' => 'string',
    'location_city_subsection' => 'string',
    'location_municipality' => 'string',
    'location_sub_province' => 'string',
    'location_province' => 'string',
    'location_postal_code_1' => 'string',
    'location_nation' => 'string',
    'phone_meeting_number' => 'string',
    'virtual_meeting_link' => 'string',
    'virtual_meeting_additional_info' => 'string',
    'contact_name_1' => 'string',
    'contact_name_2' => 'string',
    'contact_phone_1' => 'string',
    'contact_phone_2' => 'string',
    'contact_email_1' => 'string',
    'contact_email_2' => 'string',
    'bus_lines' => 'string',
    'train_line' => 'string',
    'comments' => 'string'
} );

__PACKAGE__->attribute_map( {
    'service_body_id' => 'serviceBodyId',
    'format_ids' => 'formatIds',
    'venue_type' => 'venueType',
    'temporarily_virtual' => 'temporarilyVirtual',
    'day' => 'day',
    'start_time' => 'startTime',
    'duration' => 'duration',
    'time_zone' => 'timeZone',
    'latitude' => 'latitude',
    'longitude' => 'longitude',
    'published' => 'published',
    'email' => 'email',
    'world_id' => 'worldId',
    'name' => 'name',
    'location_text' => 'location_text',
    'location_info' => 'location_info',
    'location_street' => 'location_street',
    'location_neighborhood' => 'location_neighborhood',
    'location_city_subsection' => 'location_city_subsection',
    'location_municipality' => 'location_municipality',
    'location_sub_province' => 'location_sub_province',
    'location_province' => 'location_province',
    'location_postal_code_1' => 'location_postal_code_1',
    'location_nation' => 'location_nation',
    'phone_meeting_number' => 'phone_meeting_number',
    'virtual_meeting_link' => 'virtual_meeting_link',
    'virtual_meeting_additional_info' => 'virtual_meeting_additional_info',
    'contact_name_1' => 'contact_name_1',
    'contact_name_2' => 'contact_name_2',
    'contact_phone_1' => 'contact_phone_1',
    'contact_phone_2' => 'contact_phone_2',
    'contact_email_1' => 'contact_email_1',
    'contact_email_2' => 'contact_email_2',
    'bus_lines' => 'bus_lines',
    'train_line' => 'train_line',
    'comments' => 'comments'
} );

__PACKAGE__->mk_accessors(keys %{__PACKAGE__->attribute_map});


1;
