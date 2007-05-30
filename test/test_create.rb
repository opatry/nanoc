require 'test/unit'

require File.dirname(__FILE__) + '/test_helper.rb'

class CreateTest < Test::Unit::TestCase
  def setup
    $quiet = true
    FileManager.create_dir 'tmp'
  end

  def teardown
    FileUtils.remove_entry_secure 'tmp'
    $quiet = false
  end

  def test_create_site
    FileUtils.cd('tmp')
    Nanoc::Creator.create_site('site')
    FileUtils.cd('..')

    assert File.directory?('tmp/site/')

    assert File.file?('tmp/site/config.yaml')
    assert File.file?('tmp/site/meta.yaml')
    assert File.file?('tmp/site/Rakefile')

    assert File.directory?('tmp/site/assets/')

    assert File.directory?('tmp/site/content/')
    assert File.file?('tmp/site/content/content.txt')
    assert File.file?('tmp/site/content/meta.yaml')

    assert File.directory?('tmp/site/layouts/')
    assert File.file?('tmp/site/layouts/default.erb')

    assert File.directory?('tmp/site/lib/')
    assert File.file?('tmp/site/lib/default.rb')

    assert File.directory?('tmp/site/output/')

    assert File.directory?('tmp/site/templates/')
    assert File.directory?('tmp/site/templates/default/')
    assert File.file?('tmp/site/templates/default/default.txt')
    assert File.file?('tmp/site/templates/default/meta.yaml')

    assert File.directory?('tmp/site/tasks/')
    assert File.file?('tmp/site/tasks/default.rake')
  end

  def test_create_page
    FileUtils.cd('tmp')
    Nanoc::Creator.create_site('site')
    FileUtils.cd('site')
    Nanoc::Creator.create_page('moo')
    FileUtils.cd('..')
    FileUtils.cd('..')

    assert File.directory?('tmp/site/content/moo/')
    assert File.file?('tmp/site/content/moo/moo.txt')
    assert File.file?('tmp/site/content/moo/meta.yaml')
  end

  def test_create_template
    FileUtils.cd('tmp')
    Nanoc::Creator.create_site('site')
    FileUtils.cd('site')
    Nanoc::Creator.create_template('moo')
    FileUtils.cd('..')
    FileUtils.cd('..')

    assert File.directory?('tmp/site/templates/moo/')
    assert File.file?('tmp/site/templates/moo/moo.txt')
    assert File.file?('tmp/site/templates/moo/meta.yaml')
  end
end
