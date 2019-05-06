# frozen_string_literal: true

module API
  module V2
    module Admin
      class Activities < Grape::API
        resource :activities do
          desc 'Returns array of activities as paginated collection',
          security: [{ "BearerToken": [] }],
          failure: [
            { code: 401, message: 'Invalid bearer token' }
          ]
          params do
            optional :page,
                     type: { value: Integer, message: 'admin.activities.non_integer_page' },
                     values: { value: -> (p){ p.try(:positive?) }, message: 'admin.activities.non_positive_page'},
                     default: 1,
                     desc: 'Page number (defaults to 1).'
            optional :limit,
                     type: { value: Integer, message: 'admin.activities.non_integer_limit' },
                     values: { value: 1..100, message: 'admin.activities.invalid_limit' },
                     default: 100,
                     desc: 'Number of activities per page (defaults to 100, maximum is 100).'
          end
          get do
            Activity.all.order(:desc).tap { |q| present paginate(q), with: API::V2::Entities::Activity }
          end


          desc 'Returns array of activities as paginated collection',
          security: [{ "BearerToken": [] }],
          failure: [
            { code: 401, message: 'Invalid bearer token' }
          ]
          params do
            optional :page,
                     type: { value: Integer, message: 'admin.activities.non_integer_page' },
                     values: { value: -> (p){ p.try(:positive?) }, message: 'admin.activities.non_positive_page'},
                     default: 1,
                     desc: 'Page number (defaults to 1).'
            optional :limit,
                     type: { value: Integer, message: 'admin.activities.non_integer_limit' },
                     values: { value: 1..100, message: 'admin.activities.invalid_limit' },
                     default: 100,
                     desc: 'Number of activities per page (defaults to 100, maximum is 100).'
          end
          get '/:uid' do
            target_user = User.find_by_uid(uid)
            Activity.all.tap { |q| present paginate(q), with: API::V2::Entities::Activity }
          end
        end
      end
    end
  end
end
