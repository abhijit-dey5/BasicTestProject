class testdefine {
    define testdefine ($data) {
      file {"$title":
        ensure  => file,
        content => $data,
      }
    }

    testdefine {'/var/tmp/puppetfile1':
      data => "The name of the file is puppetfile1 and it is created by puppet\n",
    }

    testdefine {'/var/tmp/puppetfile2':
      data => "The name of the file is puppetfile2 and it is created by puppet\n",
    }
    testdefine {'/var/tmp/puppetfile3':
      data => "The name of the file is puppetfile3 and it is created by puppet\n",
    }
}

include testdefine
    
