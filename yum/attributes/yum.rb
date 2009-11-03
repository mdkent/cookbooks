yum Mash.new unless attribute?("yum")

# A lot more can be broken out here, this is just a start
yum[:installonly_limit] = 5  unless yum.has_key?(:installonly_limit)
# Prefer our own arch when 'yum install foo' is invoked
yum[:multilib_policy] = [ "best" ] unless yum.has_key?(:multilib_policy)
# Actually keeps i386 from yum list output
yum[:exclude] = [ "*.i?86" ] unless yum.has_key?(:exclude)
