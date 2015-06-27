require 'spec_helper'

describe Router do

  let(:router) {
    r = Router.new
    r.add('/top', 1)
    r.add('/users', 2)
    r.add('/users/me', 3)
    r.add('/users/me/profile', 4)
    r.add('/users/:id', 5)
    r.add('/users/:id/profile', 6)
    r.add('/users/:user_id/articles/:id', 7)
    r
  }

  it 'routes correctly' do
    expect(router.match('/top')).to(
      match({ dest: 1, captures: {} })
    )
    expect(router.match('/users')).to(
      match({ dest: 2, captures: {} })
    )
    expect(router.match('/users/me')).to(
      match({ dest: 3, captures: {} })
    )
    expect(router.match('/users/me/profile')).to(
      match({ dest: 4, captures: {} })
    )
  end

  it 'captures correctly' do
    expect(router.match('/users/3')).to(
      match({ dest: 5, captures: { id: '3' } })
    )
    expect(router.match('/users/foo/profile')).to(
      match({ dest: 6, captures: { id: 'foo' } })
    )
    expect(router.match('/users/me/articles/123')).to(
      match({ dest: 7, captures: { user_id: 'me', id: '123' } })
    )
  end

end
